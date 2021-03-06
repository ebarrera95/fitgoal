//
//  SignUpViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AuthenticationTypeSwitcherViewDelegate, IconViewDelegate, AuthenticationFormViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let backgroundView = AuthenticationBackgroundView()
    
    private let avatarView = IconView(iconType: .avatarChooser)
    
    private let authenticationSwitcherView = AuthenticationTypeSwitcherView(type: .login)
    
    private let authenticationFormView = AuthenticationFormView(type: .signUp)
    
    private let signUpValidator = SignUpValidator()

    private let mainLabel: UILabel = {
        let label = UILabel()
        let text = "SIGNUP".formattedText(
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
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        let title = "Create Account".formattedText(
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
            avatarView,
            mainLabel,
            createAccountButton,
            authenticationSwitcherView,
            authenticationFormView
        ]
        scrollView.addMultipleSubviews(views)
        setConstraints()
        
        authenticationSwitcherView.delegate = self
        avatarView.delegate = self
        authenticationFormView.delegate = self
        
        createAccountButton.addTarget(self, action: #selector(presentViewController), for: .touchUpInside)
        
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
        
        avatarView.frame = CGRect(
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
        
        createAccountButton.frame = CGRect(
            x: 16,
            y: view.bounds.maxY - 200,
            width: view.bounds.width - 32,
            height: 52
        )
        
        createAccountButton.layer.cornerRadius = createAccountButton.bounds.height/2
    }
    
    @objc private func dismissKeyboard() {
        authenticationFormView.endEditing(true)
    }
    
    @objc private func presentViewController() {
        if signUpValidator.isUserInputValid() {
            let customAuth = CustomAuthentication(
                name: signUpValidator.name.userInput,
                email: signUpValidator.email.userInput,
                password: signUpValidator.password.userInput
            )
            self.present(AuthenticationViewController(authMethod: .custom(customAuth), authenticationType: .signUp), animated: true)
        } else {
            print("user input is not valid")
            return
        }
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

    func userWillChangeAvatar() {
        print("Will mangage choosing avatar form camara or library")
    }

    func userDidSwitchAuthenticationType() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    func userDidEndEditingSection(withTextFieldType textFieldType: TextFieldType, input: String) {
        switch textFieldType {
        case .userName:
            signUpValidator.name.userInput = input
            showAuthenticationMessage(inSectionWith: textFieldType, for: signUpValidator.name.state)
        case .emailAddress:
            signUpValidator.email.userInput = input
            showAuthenticationMessage(inSectionWith: textFieldType, for: signUpValidator.email.state)
        case .password:
            signUpValidator.password.userInput = input
            showAuthenticationMessage(inSectionWith: textFieldType, for: signUpValidator.password.state)
        case .confirmPassword:
            signUpValidator.passwordConfirmation.userInput = input
            showAuthenticationMessage(inSectionWith: textFieldType, for: signUpValidator.passwordConfirmation.state)
        }
    }
    
    private func showAuthenticationMessage(inSectionWith textFieldType: TextFieldType, for state: UserInfoState) {
        switch state {
        case .valid:
            return
        case .invalid(invalidStateInfo: let reason):
            authenticationFormView.showAuthenticationMessage(message: reason.message, inSectionWithTextFieldType: textFieldType)
        }
    }
    
     //MARK: -Constraints
    func setConstraints() {
        setScrollViewConstraints()
        setLoginStackConstraints()
        setSingUpStackConstraints()
        setMainLabelConstraints()
    }
    
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func setLoginStackConstraints() {
        authenticationSwitcherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authenticationSwitcherView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            authenticationSwitcherView.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 64)
        ])
    }
    
    private func setSingUpStackConstraints() {
        authenticationFormView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authenticationFormView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            authenticationFormView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24),
            authenticationFormView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -64)
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
