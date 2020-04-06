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
    
    private let appPreferences = AppPreferences()
    
    private var completion: SignInCallback?
    
    private var socialMediaType: SocialMedia
    
    init(socialMedia: SocialMedia) {
        self.socialMediaType = socialMedia
        super.init()
    }

    func authenticate(sender: UIViewController, completion: @escaping SignInCallback) {
        switch socialMediaType {
        case .facebook:
            facebookSignIn(sender: sender, completion: completion)
        case .google:
            GIDSignIn.sharedInstance()?.delegate = self
            googleSignIn(sender: sender, completion: completion)
        case .twitter:
            return
        }
    }
    
    //MARK: -Google
    private func googleSignIn(sender: UIViewController, completion: @escaping SignInCallback) {
        self.completion = completion
        GIDSignIn.sharedInstance()?.presentingViewController = sender
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            completion?(.failure(error))
        }
        else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.idToken,
                accessToken: authentication.accessToken
            )
            Auth.auth().signIn(with: credential) { (authResults, error) in
                if let error = error {
                    self.completion?(.failure(error))
                } else {
                    guard let name = user.profile.name else { return }
                    guard let email = user.profile.email else { return }
                    let userInfo = UserInformation(name: name, email: email)
                    self.appPreferences.loggedInUser = userInfo
                    print("Log as: \(authResults!)")
                }
            }
            completion?(.success(()))
        }
    }
    
    //MARK: - Facebook
    
    private func facebookSignIn(sender: UIViewController, completion: @escaping SignInCallback) {
        let permissions = ["public_profile", "email"]
        LoginManager().logIn(permissions: permissions, from: sender) { (logInResuts, error) in
            if let error = error {
                completion(.failure(error))
            }
            else {
                guard let logInResuts = logInResuts else {
                    let error = LoginError.noLogInResultsFound
                    completion(.failure(error))
                    return
                }
                
                if logInResuts.isCancelled {
                    let error = LoginError.userCanceledLogIn
                    completion(.failure(error))
                }
                else {
                    guard let user = Auth.auth().currentUser else {
                        let error = MissingUserInfoError.noUserFound
                        completion(.failure(error))
                        return
                    }
                    
                    guard let email = user.email else {
                        let error = MissingUserInfoError.noEmailFound
                        completion(.failure(error))
                        return
                    }
                    
                    Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethods, error) in
                        if let error = error {
                            completion(.failure(error))
                        }
                        else if signInMethods != nil && !signInMethods!.contains("facebook.com") {
                            self.mergeNewUserWith(currentUser: user, completion: completion)
                        } else {
                            self.createNewUser(completion: completion)
                        }
                    }
                }
            }
        }
    }
    
    private func mergeNewUserWith(currentUser: User, completion: @escaping SignInCallback) {
        do {
            let credentials = try getFacebookCredentials()
            currentUser.link(with: credentials) { (dataResults, error) in
                self.manageResutls(dataResults: dataResults, error: error, completion: completion)
            }
        }
        catch {
            completion(.failure(error))
        }
    }
    
    private func createNewUser(completion: @escaping SignInCallback) {
        do {
            let credentials = try getFacebookCredentials()
            Auth.auth().signIn(with: credentials) { ( dataResults, error) in
                self.manageResutls(dataResults: dataResults, error: error, completion: completion)
            }
        } catch {
            completion(.failure(error))
        }
    }
    /*
     I've moved this part of the logic to an independent func to avoid repeating code. Not sure if it's the best way
     to manage this because when you read the funcs `createNewUser` and `mergeNewUserWith` it's not clear when the
     `completion(.success(()))` case will happen
     */
    private func manageResutls(dataResults: AuthDataResult?, error: Error?, completion: @escaping SignInCallback) {
        if let error = error {
            completion(.failure(error))
        } else {
            do {
                guard let user = dataResults?.user else {
                    let error = MissingUserInfoError.noUserFound
                    completion(.failure(error))
                    return
                }
                let userInfo = try self.create(user: user)
                self.appPreferences.loggedInUser = userInfo
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func getFacebookCredentials() throws -> AuthCredential {
        guard let accessToken = AccessToken.current else { throw LoginError.noAuthCredentialsFound }
        return FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
    }
    
    private func create(user: User) throws  -> UserInformation {
        guard let name = user.displayName else { throw MissingUserInfoError.noNameFound }
        guard let email = user.email else { throw MissingUserInfoError.noEmailFound }
        return UserInformation(name: name, email: email)
    }
}


private enum LoginError: Error {
    case userCanceledLogIn
    case noAuthCredentialsFound
    case noLogInResultsFound
}

private enum MissingUserInfoError: Error {
    case noUserFound
    case noNameFound
    case noEmailFound
}

enum SocialMedia {
    case facebook
    case google
    case twitter
}
