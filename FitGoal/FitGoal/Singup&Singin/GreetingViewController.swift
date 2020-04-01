//
//  GreetingViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class GreetingViewController: UIViewController, AuthenticationTypeSwitcherViewDelegate, SocialMediaAuthenticationViewDelegate {
    
    private let backgroundView = BackgroundView()
    
    private let appIconView = IconView(iconType: .appIcon)
    
    private let socialMediaAuthentication = SocialMediaAuthenticationView()
    
    private let authenticationSwitcherView = AuthenticationTypeSwitcherView(type: .signUp)
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        let views = [
            backgroundView,
            appIconView,
            mainLabel,
            socialMediaAuthentication,
            createAccountButton,
            greetingText,
            authenticationSwitcherView
        ]
        view.addMultipleSubviews(views)
        setConstraints()
        
        createAccountButton.addTarget(self, action: #selector(presentViewController), for: .touchUpInside)
        authenticationSwitcherView.delegate = self
        socialMediaAuthentication.delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: 1/3 * view.bounds.height
        )
        
        socialMediaAuthentication.frame = CGRect(
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
        GIDSignIn.sharedInstance().signIn()
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
}
