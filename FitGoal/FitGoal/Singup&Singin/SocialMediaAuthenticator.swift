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
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func googleSignIn(sender: UIViewController, completion: @escaping SignInCallback) {
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
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
    
    func facebookSignIn(sender: UIViewController, completion: @escaping SignInCallback) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile", "email"], from: sender) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if (result?.isCancelled) != nil {
                    let error = LoginError.userCanceledLogIn
                    completion(.failure(error))
                }
                guard let accessToken = AccessToken.current else { return }
                let credentials = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
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
        self.completion = completion
    }
    
    func facebookLogOut() {
        let manager = LoginManager()
        manager.logOut()
        appPreferences.loggedInUser = nil
    }
}

private enum LoginError: Error {
    case userCanceledLogIn
}
