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
            if let error = error { completion(.failure(error)) }
            else {
                guard let logInResuts = logInResuts else { return }
                if logInResuts.isCancelled {
                    let error = LoginError.userCanceledLogIn
                    completion(.failure(error))
                }
                else {
                    guard let user = Auth.auth().currentUser else { return }
                    guard let email = user.email else { return }
                    Auth.auth().fetchSignInMethods(forEmail: email) { (signInmethods, error) in
                        if let error = error { completion(.failure(error)) }
                        else if signInmethods != nil {
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
        guard let credentials = getFacebookCredentials() else { return }
        currentUser.link(with: credentials) { (dataResults, error) in
            if let error = error {
                completion(.failure(error))
            }
            self.createUser(with: dataResults, completion: completion)
        }
    }
    
    private func createNewUser(completion: @escaping SignInCallback) {
        guard let credentials = getFacebookCredentials() else { return }
        Auth.auth().signIn(with: credentials) { ( dataResults, error) in
            if let error = error {
                completion(.failure(error))
            }
            self.createUser(with: dataResults, completion: completion)
        }
    }
    
    private func getFacebookCredentials() -> AuthCredential? {
        guard let accessToken = AccessToken.current else { return nil }
        return FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
    }
    
    private func createUser(with dataResults: AuthDataResult?, completion: @escaping SignInCallback) {
        guard let user = dataResults?.user else { return }
        guard let name = user.displayName else { return }
        guard let email = user.email else { return }
        let userInfo = UserInformation(name: name, email: email)
        self.appPreferences.loggedInUser = userInfo
        completion(.success(()))
    }
}


private enum LoginError: Error {
    case userCanceledLogIn
    case noUserFound
    case noNameFound
    case noEmailFound
}

enum SocialMedia {
    case facebook
    case google
    case twitter
}
