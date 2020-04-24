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

class Authenticator: NSObject, GIDSignInDelegate {
    
    typealias SignInCallback = (Result<Void, Error>) -> Void
    typealias UserInfoCallback = (Result<UserInformation, Error>) -> Void
    
    private let appPreferences = AppPreferences()
    
    private var userInfoCallback: UserInfoCallback?
    
    private var authenticationMethod: AuthenticationMethod
    
    private let twitterProvider = OAuthProvider(providerID: "twitter.com")
    
    init(authMethod: AuthenticationMethod) {
        self.authenticationMethod = authMethod
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
        
        switch authenticationMethod {
        case .custom(let customAuth):
            customSignIn(customAuth: customAuth, completion: persistIfPossible(userInfoResult:))
        case .socialMedia(let socialMedia):
            authenticate(with: socialMedia, sender: sender, completion: persistIfPossible(userInfoResult:))
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
                    self.authenticateUser(with: .facebook(accessToken: accessToken.tokenString), completion: completion)
                }
            }
        }
    }
    
    private func twitterSignIn(sender: UIViewController, completion: @escaping UserInfoCallback) {
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
    
    private func customSignIn(customAuth: CustomAuthentication, completion: @escaping UserInfoCallback) {
        let email = customAuth.email
        let userName = customAuth.name
        let password = customAuth.password
        
        Auth.auth().createUser(withEmail: email, password: password) { (dataResults, error) in
            if let error = error {
                self.handleLoginError(error: error, providerSpecifications: .custom(email: email, password: password, name: userName), completion: completion)
            } else {
                self.authenticateUser(with: .custom(email: email, password: password, name: userName), completion: completion)
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
            self.authenticateUser(with: .google(accessToken: authentication.accessToken, tokenID: authentication.idToken), completion: callback)
        }
    }
    
    //MARK: - Helper functions
    
    private func authenticate(with socialMedia: SocialMedia, sender: UIViewController, completion: @escaping UserInfoCallback) {
        switch socialMedia {
        case .facebook:
            facebookSignIn(sender: sender, completion: completion)
        case .google:
            googleSignIn(sender: sender, completion: completion)
        case .twitter:
            twitterSignIn(sender: sender, completion: completion)
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
    
    private func authenticateUser(with providerSpecifications: ProviderSpecifications, completion: @escaping UserInfoCallback) {
        let credentials = providerSpecifications.credentials
        Auth.auth().signIn(with: credentials) { (dataResults, error) in
            if let error = error {
                self.handleLoginError(error: error, providerSpecifications: providerSpecifications, completion: completion)
            } else {
                switch providerSpecifications {
                case .facebook, .twitter, .google:
                    self.parseUserInformation(from: dataResults, error: error, completion: completion)
                case .custom(_, let email, let name):
                    completion(.success(UserInformation(name: name, email: email)))
                }
            }
        }
    }
    
    private func handleLoginError(error: Error, providerSpecifications: ProviderSpecifications, completion: @escaping UserInfoCallback) {
        let nsError = error as NSError
        if nsError.code == AuthErrorCode.accountExistsWithDifferentCredential.rawValue {
            self.handleAccountExistsWithDifferentCredentials(
                error: nsError,
                providerSpecifications: providerSpecifications,
                completion: completion
            )
        } else if nsError.code == AuthErrorCode.emailAlreadyInUse.rawValue {
            completion(.failure(LoginError.emailAssociatedToExistingAccount))
        } else {
            completion(.failure(error))
        }
    }
    
    private func handleAccountExistsWithDifferentCredentials(error: NSError, providerSpecifications: ProviderSpecifications, completion: @escaping UserInfoCallback) {
        guard let email = error.userInfo[AuthErrorUserInfoEmailKey] as? String else {
            completion(.failure(error))
            return
        }
        
        Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethod, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let methods = signInMethod, !methods.contains(providerSpecifications.name) {
                let previousMethod = Provider.allCases.first(where: { methods.contains($0.rawValue) })
                guard let existingProvider = previousMethod else {
                    assertionFailure("This case will only happen: if the Firebase API changes the authentication method names or if the method that throws the error is found in the sign-in method list")
                    completion(.failure(LoginError.unrecognisedLoginMethod))
                    return
                }
                completion(.failure(LoginError.userPreviouslyLoggedIn(existingProvider.rawValue)))
            }
        }
    }
}

enum LoginError: Error {
    case userCanceledLogin
    case noAuthCredentialsFound
    case noLoginResultsFound
    case userPreviouslyLoggedIn(String)
    case unrecognisedLoginMethod
    case emailAssociatedToExistingAccount
}

enum AuthenticationMethod {
    case socialMedia(SocialMedia)
    case custom(CustomAuthentication)
}

enum SocialMedia {
    case facebook
    case google
    case twitter
}

struct CustomAuthentication {
    let name: String
    let email: String
    let password: String
}

private enum MissingUserInfoError: Error {
    case noUserFound
    case noNameFound
    case noEmailFound
    case noAuthenticationObjectFound
}

private enum Provider: String, CaseIterable {
    case facebook = "facebook.com"
    case google = "google.com"
    case twitter = "twitter.com"
    case emailAndPassword = "password"
}

private enum ProviderSpecifications {
    case facebook(accessToken: String)
    case google(accessToken: String, tokenID: String)
    case twitter(credentials: AuthCredential)
    case custom(email: String, password: String, name: String)
    
    var name: String {
        switch self {
        case .facebook:
            return Provider.facebook.rawValue
        case .google:
            return Provider.google.rawValue
        case .twitter:
            return Provider.twitter.rawValue
        case .custom:
            return Provider.emailAndPassword.rawValue
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
        case .custom(let email, let password, _):
            return EmailAuthProvider.credential(withEmail: email, password: password)
            
        }
    }
}
