//
//  AuthenticationViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 3/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    private var authenticator: Authenticator

    private let placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .large
        return placeholder
    }()
    
    private var blurEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .extraLight)
        blurEffectView.effect = blurEffect
        return blurEffectView
    }()
    
    private var loginStatus: LoginStatus? {
        didSet {
            DispatchQueue.main.async {
                switch self.loginStatus {
                case .loggedIn:
                    let vc = HomeViewController(persistance: CoreDataPersistance())
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.view.window?.rootViewController = vc
                case .attempting:
                    self.view.addSubview(self.placeholder)
                    self.placeholder.startAnimating()
                case.failed(let error):
                    if let loginError = error as? LoginError {
                        self.handle(error: loginError)
                    } else {
                        self.dismiss(animated: true) { print("Unable to login, reason: \(error)") }
                    }
                case.none:
                    return
                }
            }
        }
    }
    
    private var viewDidAppearOnce = false

    init(authMethod: AuthenticationMethod, authenticationType: AuthenticationType) {
        self.authenticator = Authenticator(authMethod: authMethod, authenticationType: authenticationType)
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurEffectView)
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewDidAppearOnce {
            login()
            viewDidAppearOnce = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurEffectView.frame = view.bounds
        placeholder.center = view.center
    }
    
    private func handle(error loginError: LoginError) {
        switch loginError {
        case .noAuthCredentialsFound, .noLoginResultsFound, .userCanceledLogin, .unrecognisedLoginMethod:
            self.dismiss(animated: true) { print("Unable to login, reason: \(loginError)") }
        case .userPreviouslyLoggedIn(let provider):
            let title = "You've previously logged in with another provider"
            let message = "Please, log in with \(provider)"
            let style = UIAlertController.Style.alert
            showLoginErrorAlert(title: title, message: message, preferredStyle: style)
        case .emailAssociatedToExistingAccount:
            let title = "You already have an account"
            let message = "Please login with email and password"
            let style = UIAlertController.Style.alert
            showLoginErrorAlert(title: title, message: message, preferredStyle: style)
        case .userEnterWrongPassword:
            let title = "Incorrect Password"
            let message = "Please, enter the right password or reset it"
            let style = UIAlertController.Style.alert
            showLoginErrorAlert(title: title, message: message, preferredStyle: style)
        case .userNotFound:
            let title = "You don't have an account"
            let message = "Please, sign up"
            let style = UIAlertController.Style.alert
            showLoginErrorAlert(title: title, message: message, preferredStyle: style)
        }
    }
    
    private func showLoginErrorAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let action = UIAlertAction(title: "Got it!", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    private func login() {
        loginStatus = .attempting
        authenticator.authenticate(sender: self) { result in
            switch result {
            case .success:
                self.loginStatus = .loggedIn
            case .failure(let error):
                self.loginStatus = .failed(error)
            }
        }
    }
}

private enum LoginStatus {
    case attempting
    case loggedIn
    case failed(Error)
}
