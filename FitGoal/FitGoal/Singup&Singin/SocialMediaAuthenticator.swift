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
    
    private let twitterProvider = OAuthProvider(providerID: "twitter.com")
    
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
            twitterSignIn(sender: sender, completion: persistIfPossible(userInfoResult:))
        }
    }
    
    private func googleSignIn(sender: UIViewController, completion: @escaping UserInfoCallback) {
        self.userInfoCallback = completion
        GIDSignIn.sharedInstance()?.presentingViewController = sender
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func facebookSignIn(sender: UIViewController, completion: @escaping UserInfoCallback) {
        let permissions = ["public_profile", "email"]
        
        LoginManager().logIn(permissions: permissions, from: sender) { (loginResults, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let loginResults = loginResults else {
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
                    self.authenticateUser(with: .facebook(accessToke: accessToken.tokenString), completion: completion)
                }
            }
        }
    }
    
    func twitterSignIn(sender: UIViewController, completion: @escaping UserInfoCallback) {
        twitterProvider.getCredentialWith(nil) { (credentials, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let credentials = credentials else {
                    completion(.failure(LoginError.noAuthCredentialsFound))
                    return
                }
                self.authenticateUser(with: .twitter(credentials: credentials), completion: completion)
            }
        }
    }
    
    // MARK: -Google Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            userInfoCallback?(.failure(error))
        } else {
            guard let authentication = user.authentication else {
                userInfoCallback?(.failure(MissingUserInfoError.noAuthenticationObjectFound))
                return
            }
            
            guard let callback = userInfoCallback else {
                assertionFailure("nil userInfoCallback")
                return
            }
            
            let credentials = AuthenticationMethod.google(accessToken: authentication.accessToken, tokenID: authentication.idToken).credentials
            Auth.auth().signIn(with: credentials) { (dataResults, error) in
                self.parseUserInformation(from: dataResults, error: error, completion: callback)
            }
        }
    }
    
    //MARK: - Helper functions
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
    
    private func authenticateUser(with authenticationMethod: AuthenticationMethod, completion: @escaping UserInfoCallback) {
        let credentials = authenticationMethod.credentials
        Auth.auth().signIn(with: credentials) { (dataResults, error) in
            if let error = error {
                self.handleLoginError(error: error, authenticationMethod: authenticationMethod, completion: completion)
            } else {
                self.parseUserInformation(from: dataResults, error: error, completion: completion)
            }
        }
    }
    
    private func handleLoginError(error: Error, authenticationMethod: AuthenticationMethod, completion: @escaping UserInfoCallback) {
        let nsError = error as NSError
        if nsError.code == AuthErrorCode.accountExistsWithDifferentCredential.rawValue {
            self.handleAccountExistsWithDifferentCredentials(error: nsError, authenticationMethod: authenticationMethod, completion: completion)
        } else {
            completion(.failure(error))
        }
    }
    
    private func handleAccountExistsWithDifferentCredentials(error: NSError, authenticationMethod: AuthenticationMethod, completion: @escaping UserInfoCallback) {
        let email = error.userInfo[AuthErrorUserInfoEmailKey] as! String
        Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethod, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let methods = signInMethod, !methods.contains(authenticationMethod.name) {
                let previousMethod = SocialMedia.allCases.first(where: { methods.contains($0.rawValue) })
                guard let existingMethod = previousMethod else {
                    assertionFailure("This case will only happen: if the Firebase API changes the authentication method names or if the method that throws the error is found in the sign-in method list")
                    completion(.failure(LoginError.unrecognisedLoginMethod))
                    return
                }
                completion(.failure(LoginError.userPreviouslyLoggedInWith(existingMethod)))
            }
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
    case noAuthenticationObjectFound
}

enum SocialMedia: String, CaseIterable {
    case facebook = "facebook.com"
    case google = "google.com"
    case twitter = "twitter.com"
}

private enum AuthenticationMethod {
    case facebook(accessToke: String)
    case google(accessToken: String, tokenID: String)
    case twitter(credentials: AuthCredential)
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
        case .twitter(let credentials):
            return credentials
        case .custom:
            fatalError()
        }
    }
}
