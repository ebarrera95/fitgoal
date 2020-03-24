//
//  SignUpViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AuthenticationTypeDelegate, UserAvatarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let scrollView = UIScrollView()
    
    private var backgroundView = BackgroundView(
        mainLabelText: "SIGNUP",
        avatarImage: UIImage(imageLiteralResourceName: "addAvatar"),
        authenticationType: .signUp
    )
    
    //TODO: Fix name
    private var connectionToLoginVC = AuthenticationLink(authenticationType: .login)
    
    private var createAccount: UIButton = {
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
    
    private var signUpForm = AuthenticationForm(authenticationType: .signUp)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
//        scrollView.frame = view.bounds
//
//        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
//
//        createAccount.frame = CGRect(x: 16, y: view.bounds.maxY - 200, width: view.bounds.width - 32, height: 52)
//        createAccount.layer.cornerRadius = createAccount.bounds.height/2
        
        view.addSubview(scrollView)
        
        let views = [backgroundView, createAccount, connectionToLoginVC, signUpForm]
        scrollView.addMultipleSubviews(views)
        
        setConstraints()
        
        connectionToLoginVC.delegate = self
        //backgroundView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        createAccount.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds

        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        createAccount.frame = CGRect(x: 16, y: view.bounds.maxY - 200, width: view.bounds.width - 32, height: 52)
        createAccount.layer.cornerRadius = createAccount.bounds.height/2
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
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
        print("Will mangage camara and library issuse")
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
}
