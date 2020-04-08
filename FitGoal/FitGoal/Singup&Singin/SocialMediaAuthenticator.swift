//
//  SocialMediaAuthenticator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SocialMediaAuthenticator: NSObject, GIDSignInDelegate {
    
    typealias SignInCallback = (Result<Void, Error>) -> Void
    typealias UserInfoCallback = (Result<UserInformation, Error>) -> Void
    
    private let appPreferences = AppPreferences()
    
    private var userInfoCallback: UserInfoCallback?
    
    private var socialMedia: SocialMedia
    
    init(socialMedia: SocialMedia) {
        self.socialMedia = socialMedia
        super.init()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func authenticate(sender: UIViewController, completion: @escaping SignInCallback) {
        func persistIfPossible(userInfoResult: Result<UserInformation, Error>) {
            switch userInfoResult {
            case .success(let userInfo):
                appPreferences.loggedInUser = userInfo
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        switch self.socialMedia {
        case .facebook:
            facebookSignIn(sender: sender, completion: persistIfPossible(userInfoResult:))
        case .google:
            googleSignIn(sender: sender, completion: persistIfPossible(userInfoResult:))
        case .twitter:
            return
        }
    }
    
    private func googleSignIn(sender: UIViewController, completion: @escaping UserInfoCallback) {
        self.userInfoCallback = completion
        GIDSignIn.sharedInstance()?.presentingViewController = sender
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func facebookSignIn(sender: UIViewController, completion: @escaping UserInfoCallback) {
        let permissions = ["public_profile", "email"]
        
        LoginManager().logIn(permissions: permissions, from: sender) { (loginResuts, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let loginResults = loginResuts else {
                    completion(.failure(LoginError.noLoginResultsFound))
                    return
                }
                if loginResults.isCancelled {
                    completion(.failure(LoginError.userCanceledLogin))
                } else {
                    guard let accessToken = loginResults.token else {
                        completion(.failure(LoginError.noAuthCredentialsFound))
                        return
                    }
                    
                    self.requestFacebookEmail(using: accessToken) { (results) in
                        switch results {
                        case .failure(let error):
                            completion(.failure(error))
                        case .success(let email):
                            let credentials = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                            self.authenticateUser(using: .facebook, with: credentials, userEmail: email, completion: completion)
                        }
                    }
                }
            }
        }
    }
    
    private func requestFacebookEmail(using accessToken: AccessToken, emailCallback: @escaping (Result<String, Error>) -> Void) {
        let graphRequest = GraphRequest(
            graphPath: "me",
            parameters: ["fields":"email"],
            tokenString: accessToken.tokenString,
            version: nil,
            httpMethod: HTTPMethod(rawValue: "GET")
        )
        
        graphRequest.start { (test, result, error) in
            if let error = error {
                emailCallback(.failure(error))
            } else {
                guard let result = result else {
                    emailCallback(.failure(LoginError.noLoginResultsFound))
                    return
                }
                
                guard let userInformation = result as? [String:String] else {
                    emailCallback(.failure(MissingUserInfoError.noUserFound))
                    return
                }

                guard let email = userInformation["email"] else {
                    emailCallback(.failure(MissingUserInfoError.noEmailFound))
                    return
                }
                
                emailCallback(.success(email))
            }
        }
    }
    
    private func authenticateUser(using socialMedia: SocialMedia, with credential: AuthCredential, userEmail email: String, completion: @escaping UserInfoCallback) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethods, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let methods = signInMethods, !methods.contains(socialMedia.rawValue) {
                let previousMethod = SocialMedia.allCases.first(where: { methods.contains($0.rawValue) })
                if previousMethod != nil {
                    completion(.failure(LoginError.userPreviouslyLoggedInWith(previousMethod!)))
                } else {
                    assertionFailure("")
                    completion(.failure(LoginError.unrecognisedLoginMethod))
                }
            } else {
                self.signIn(using: credential, completion: completion)
            }
        }
    }
    
    private func signIn(using credentials: AuthCredential, completion: @escaping UserInfoCallback) {
        Auth.auth().signIn(with: credentials) { (dataResults, error) in
            self.parseUserInformation(from: dataResults, error: error, completion: completion)
        }
    }
    
    private func parseUserInformation(from dataResults: AuthDataResult?, error: Error?, completion: UserInfoCallback) {
        if let error = error {
            completion(.failure(error))
        } else {
            guard let user = dataResults?.user else {
                completion(.failure(MissingUserInfoError.noUserFound))
                return
            }
            
            guard let name = user.displayName else {
                completion(.failure(MissingUserInfoError.noNameFound))
                return
            }
            
            guard let email = user.email else {
                completion(.failure(MissingUserInfoError.noEmailFound))
                return
            }
            
            completion(.success(UserInformation(name: name, email: email)))
        }
    }
    
    // MARK: -Google Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            userInfoCallback?(.failure(error))
        } else {
            guard let authentication = user.authentication else { return }

            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.idToken,
                accessToken: authentication.accessToken
            )
            
            guard let email = user.profile.email else {
                userInfoCallback?(.failure(MissingUserInfoError.noEmailFound))
                return
            }
            
            guard let callback = userInfoCallback else { return }
            self.authenticateUser(using: .google, with: credential, userEmail: email, completion: callback)
        }
    }
}

enum LoginError: Error {
    case userCanceledLogin
    case noAuthCredentialsFound
    case noLoginResultsFound
    case userPreviouslyLoggedInWith(SocialMedia)
    case unrecognisedLoginMethod
}

private enum MissingUserInfoError: Error {
    case noUserFound
    case noNameFound
    case noEmailFound
}

enum SocialMedia: String, CaseIterable {
    case facebook = "facebook.com"
    case google = "google.com"
    case twitter = "twitter.com"
}
