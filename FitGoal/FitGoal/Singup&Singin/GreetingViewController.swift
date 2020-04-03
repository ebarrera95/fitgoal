//
//  GreetingViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController, AuthenticationTypeSwitcherViewDelegate, SocialMediaAuthenticationViewDelegate {
    
    private let authenticator = SocialMediaAuthenticator()
    
    private let backgroundView = BackgroundView()
    
    private let appIconView = IconView(iconType: .appIcon)
    
    private let socialMediaAuthenticationView = SocialMediaAuthenticationView()
    
    private let authenticationSwitcherView = AuthenticationTypeSwitcherView(type: .signUp)
    
    private let placeholderView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.5)
        return view
    }()
    
    let placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = .white
        placeholder.style = .large
        return placeholder
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        let text = "HELLO".formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: #colorLiteral(red: 0.36, green: 0.37, blue: 0.4, alpha: 1),
            kern: -0.12
        )
        label.attributedText = text
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        let title = "Create Account".formattedText(font: "Roboto-Bold", size: 17, color: .white, kern: 0)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private let greetingText: UITextView = {
        let text = UITextView()
        let string = "Start transforming the way \n you enjoy you life"
        let attributedString = string.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0,
            lineSpacing: 6
        )
        text.isEditable = false
        text.isScrollEnabled = false
        text.isSelectable = false
        text.backgroundColor = .clear
        text.attributedText = attributedString
        text.textAlignment = .center
        return text
    }()
    
    private var loginStatus = LoginStatus.loggedOut {
        didSet {
            DispatchQueue.main.async {
                switch self.loginStatus {
                    case .loggedIn:
                        let vc = HomeViewController(persistance: CoreDataPersistance())
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true)
                    case .attempting:
                        self.view.addSubview(self.placeholderView)
                        self.placeholderView.addSubview(self.placeholder)
                        self.placeholder.center = self.view.center
                        self.setPlaceholderViewConstraints()
                        self.placeholder.startAnimating()
                    case.failed(let error):
                        self.placeholder.stopAnimating()
                        self.placeholderView.removeFromSuperview()
                        print("Unable to login, reason: \(error)")
                    case.loggedOut:
                        return
                    }
                }
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        let views = [
            backgroundView,
            appIconView,
            mainLabel,
            socialMediaAuthenticationView,
            createAccountButton,
            greetingText,
            authenticationSwitcherView
        ]
        view.addMultipleSubviews(views)
        setConstraints()
        
        createAccountButton.addTarget(self, action: #selector(presentViewController), for: .touchUpInside)
        authenticationSwitcherView.delegate = self
        socialMediaAuthenticationView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: 1/3 * view.bounds.height
        )
        
        socialMediaAuthenticationView.frame = CGRect(
            x: 0,
            y: 2/3 * view.bounds.maxY,
            width: view.bounds.width,
            height: 1/3 * view.bounds.height
        )
        
        createAccountButton.frame = CGRect(
            x: 16,
            y: view.bounds.midY + 50,
            width: view.bounds.width - 32,
            height: 52
        )
        
        appIconView.frame = CGRect(
            x: view.bounds.midX - 42,
            y: 130,
            width: 104,
            height: 104
        )
        
        createAccountButton.layer.cornerRadius = createAccountButton.bounds.height/2
    }

    @objc private func presentViewController() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    func userWillLoginWithGoogle() {
        loginStatus = .attempting
        authenticator.googleSignIn(sender: self) { result in
            switch result {
            case .success:
                self.loginStatus = .loggedIn
            case .failure(let error):
                self.loginStatus = .failed(error)
            }
        }
    }
    
    func userWillLoginWithFacebook() {
        loginStatus = .attempting
        authenticator.facebookSignIn(sender: self) { (result) in
            switch result {
            case .success:
                self.loginStatus = .loggedIn
            case .failure(let error):
                self.loginStatus = .failed(error)
            }
        }
    }
    
    func userDidSwitchAuthenticationType() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    //MARK: -Constraints
    
    private func setConstraints() {
        setTextConstraints()
        setLoginStackConstraints()
        setMainLabelConstraints()
    }
    
    private func setTextConstraints() {
        greetingText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingText.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setLoginStackConstraints() {
        authenticationSwitcherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authenticationSwitcherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authenticationSwitcherView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
    
    func setMainLabelConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }
    
    func setPlaceholderViewConstraints() {
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: view.topAnchor),
            placeholderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            placeholderView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

enum LoginStatus {
    case loggedOut
    case attempting
    case loggedIn
    case failed(Error)
}
