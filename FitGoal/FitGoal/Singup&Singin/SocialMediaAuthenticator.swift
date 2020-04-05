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
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile", "email"], from: sender) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result = result else { return }
                if result.isCancelled {
                    let error = LoginError.userCanceledLogIn
                    completion(.failure(error))
                }
                guard let accessToken = AccessToken.current else { return }
                let credentials = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                /*This part of the function looks for a previous user logged in with these credentials but with a different providers.
                 Because of the behavior of the GoogleSignIn, it looks as if this functionality is implicit at some point
                */
                if let user = Auth.auth().currentUser {
                    guard let name = user.displayName else { return }
                    guard let email = user.email else { return }
                    let userInfo = UserInformation(name: name, email: email)
                    self.appPreferences.loggedInUser = userInfo
                    Auth.auth().fetchSignInMethods(forEmail: email, completion: nil)
                    user.link(with: credentials, completion: nil)
                    completion(.success(()))
                } else {
                    Auth.auth().signIn(with: credentials) { (user, error) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            guard let user = Auth.auth().currentUser else { return }
                            guard let name = user.displayName else { return }
                            guard let email = user.email else { return }
                            let userInfo = UserInformation(name: name, email: email)
                            self.appPreferences.loggedInUser = userInfo
                            completion(.success(()))
                        }
                    }
                }
            }
        }
        self.completion = completion
    }
}

private enum LoginError: Error {
    case userCanceledLogIn
}

enum SocialMedia {
    case facebook
    case google
    case twitter
}
