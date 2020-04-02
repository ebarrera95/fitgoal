//
//  LoginViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthenticationTypeSwitcherViewDelegate, SocialMediaAuthenticationViewDelegate {
    
    private let authenticator = SocialMediaAuthenticator()
    
    private let backgroundView = BackgroundView()
    
    private let appIconView = IconView(iconType: .appIcon)
    
    private let authenticationSwitcherView = AuthenticationTypeSwitcherView(type: .signUp)
    
    private let socialMediaAuthenticationView = SocialMediaAuthenticationView()
    
    private let loginForm = AuthenticationFormView(type: .login)
    
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

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(scrollView)
        let views = [
            backgroundView,
            appIconView,
            mainLabel,
            loginButton,
            loginForm,
            socialMediaAuthenticationView,
            authenticationSwitcherView,
        ]
        scrollView.addMultipleSubviews(views)
        setConstraints()
        
        authenticationSwitcherView.delegate = self
        socialMediaAuthenticationView.delegate = self

        loginButton.addTarget(self, action: #selector(presentViewController), for: .touchUpInside)
        
        let dismissKeyBoardTap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        scrollView.addGestureRecognizer(dismissKeyBoardTap)
    
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = view.frame.size
        
        socialMediaAuthenticationView.frame = CGRect(
            x: 0,
            y: 2/3 * view.bounds.maxY,
            width: view.bounds.width,
            height: 1/3 * view.bounds.height
        )
        
        appIconView.frame = CGRect(
            x: view.bounds.midX - 42,
            y: 130,
            width: 104,
            height: 104
        )
        
        backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: 1/3 * view.bounds.height
        )
        
        loginButton.frame = CGRect(
            x: 16,
            y: view.bounds.midY + 72,
            width: view.bounds.width - 32,
            height: 52
        )
        
        loginButton.layer.cornerRadius = loginButton.bounds.height/2
    }
    
    @objc private func dismissKeyboard() {
            loginForm.endEditing(true)
    }
    
    @objc private func presentViewController() {
        let vc = HomeViewController(persistance: CoreDataPersistance())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let contentInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardSize.height,
            right: 0.0
        )
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func userWillLoginWithGoogle() {
        authenticator.googleSignIn(sender: self) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = HomeViewController(persistance: CoreDataPersistance())
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true)
                }
            case .failure(let error):
                print("Unable to login \(error)")
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
        setScrollViewConstraints()
        setLoginStackConstraints()
        setSignUpLinkConstraints()
        setMainLabelConstraints()
    }
    
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func setSignUpLinkConstraints() {
        authenticationSwitcherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authenticationSwitcherView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            authenticationSwitcherView.bottomAnchor.constraint(equalTo:socialMediaAuthenticationView.bottomAnchor, constant: -72)
        ])
    }
    
    private func setLoginStackConstraints() {
        loginForm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginForm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            loginForm.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24),
            loginForm.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -64)
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
