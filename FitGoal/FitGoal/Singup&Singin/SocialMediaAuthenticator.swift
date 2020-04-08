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
                            self.authenticateUser(withMethod: .facebook(accessToke: accessToken.tokenString), userEmail: email, completion: completion)
                            
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
    
    private func authenticateUser(withMethod method: AuthenticationMethod, userEmail email: String, completion: @escaping UserInfoCallback) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethods, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let methods = signInMethods, !methods.contains(method.name) {
                let previousMethod = SocialMedia.allCases.first(where: { methods.contains($0.rawValue) })
                if previousMethod != nil {
                    completion(.failure(LoginError.userPreviouslyLoggedInWith(previousMethod!)))
                } else {
                    assertionFailure("This case will only happend if the Firebase API changes the name of the Authentication Methods (e.g facebook.com by Facebook.com)")
                    completion(.failure(LoginError.unrecognisedLoginMethod))
                }
            } else {
                self.signIn(using: method.credentials, completion: completion)
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
            
            guard let email = user.profile.email else {
                userInfoCallback?(.failure(MissingUserInfoError.noEmailFound))
                return
            }
            
            guard let callback = userInfoCallback else { return }
            
            self.authenticateUser(
                withMethod: .google(accessToken: authentication.accessToken, tokenID: authentication.idToken),
                userEmail: email,
                completion: callback
            )
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

private enum AuthenticationMethod {
    case facebook(accessToke: String)
    case google(accessToken: String, tokenID: String)
    case twitter
    case custom(email: String, password: String)
    
    var name: String {
        switch self {
        case .facebook:
            return SocialMedia.facebook.rawValue
        case .google:
            return SocialMedia.google.rawValue
        case .twitter:
            return SocialMedia.twitter.rawValue
        case .custom:
            fatalError()
        }
    }
    
    var credentials: AuthCredential {
        switch self {
        case .facebook(let accessToken):
            return FacebookAuthProvider.credential(withAccessToken: accessToken)
        case let .google(accessToken, tokenID):
            return GoogleAuthProvider.credential(withIDToken: tokenID, accessToken: accessToken)
        case .twitter:
            fatalError()
        case .custom:
            fatalError()
        }
    }
}
