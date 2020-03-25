//
//  LoginViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthenticationTypeDelegate {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        let text = "LOGIN".formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: #colorLiteral(red: 0.36, green: 0.37, blue: 0.4, alpha: 1),
            kern: -0.12
        )
        label.attributedText = text
        return label
    }()
    
    private let avatarManager = AvatarManager(authenticationType: .login)
    
    private let scrollView = UIScrollView()
    
    private let backgroundView = BackgroundView()
    
    private let connectionToSignUpVC = AuthenticationLink(authenticationType: .signUp)
    
    private let socialMediaView = SocialMediaAuthentication()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        let title = "Login".formattedText(
            font: "Roboto-Bold",
            size: 17,
            color: .white,
            kern: 0
        )
        
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private let loginForm = AuthenticationForm(authenticationType: .login)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(scrollView)
        let views = [
            backgroundView,
            avatarManager,
            mainLabel,
            loginButton,
            loginForm,
            socialMediaView,
            connectionToSignUpVC
        ]
        
        scrollView.addMultipleSubviews(views)
        
        setConstraints()
        
        connectionToSignUpVC.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginButtonTap(_:)))
        loginButton.addGestureRecognizer(tap)
        
        let dismissKeyBoardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(_:)))
        view.addGestureRecognizer(dismissKeyBoardTap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds

        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        loginButton.frame = CGRect(x: 16, y: view.bounds.midY + 72, width: view.bounds.width - 32, height: 52)
        loginButton.layer.cornerRadius = loginButton.bounds.height/2
        
        socialMediaView.frame = CGRect(x: 0, y: 2/3 * view.bounds.maxY, width: view.bounds.width, height: 1/3 * view.bounds.height)
    }
    
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            loginForm.endEditing(true)
        default:
            return
        }
    }
    
    
    @objc func loginButtonTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let vc = GreetingViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            show(vc, sender: self)
        default:
            return
        }
    }
    
    func userDidSelectAuthenticationType() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    func setConstraints() {
        setLoginStackConstraints()
        setSignUpLinkConstraints()
        setMainLabelConstraints()
    }
    
    private func setSignUpLinkConstraints() {
        connectionToSignUpVC.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            connectionToSignUpVC.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            connectionToSignUpVC.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -72)
        ])
    }
    
    private func setLoginStackConstraints() {
        loginForm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginForm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            loginForm.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24),
            loginForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    func setMainLabelConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }
}
