//
//  SignUpViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AuthenticationTypeDelegate, AvatarMangerDelegate, CustomTextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showTextField() {
        
    }
    
    
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
    
    private let avatarManager = AvatarManager(authenticationType: .signUp)
    
    private let scrollView = UIScrollView()
    
    private let backgroundView = BackgroundView()
    
    private let connectionToLoginVC = AuthenticationLink(authenticationType: .login)
    
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
    
    private let signUpForm = AuthenticationForm(authenticationType: .signUp)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(scrollView)
        
        let views = [
            backgroundView,
            avatarManager,
            mainLabel,
            createAccountButton,
            connectionToLoginVC,
            signUpForm
        ]
        
        scrollView.addMultipleSubviews(views)
        
        setConstraints()
        
        connectionToLoginVC.delegate = self
        avatarManager.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(createAccountTap(_:)))
        createAccountButton.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y = -keyboardSize.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        createAccountButton.frame = CGRect(x: 16, y: view.bounds.maxY - 200, width: view.bounds.width - 32, height: 52)
        createAccountButton.layer.cornerRadius = createAccountButton.bounds.height/2
        
        let dismissKeyBoardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(_:)))
        view.addGestureRecognizer(dismissKeyBoardTap)
        
        signUpForm.customTextFieldDelegate = self
    }
    
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            signUpForm.endEditing(true)
        default:
            return
        }
    }
    
    @objc func createAccountTap(_ sender: UITapGestureRecognizer) {
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
    
    func userWillChangeAvatar() {
        print("Will mangage choosing avatar form camara or library")
    }

    func userDidSelectAuthenticationType() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    func setConstraints() {
        setLoginStackConstraints()
        setSingUpStackConstraints()
        setMainLabelConstraints()
    }
    
    private func setLoginStackConstraints() {
        connectionToLoginVC.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            connectionToLoginVC.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectionToLoginVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
    
    private func setSingUpStackConstraints() {
        signUpForm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signUpForm.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24),
            signUpForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    func setMainLabelConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }
}
