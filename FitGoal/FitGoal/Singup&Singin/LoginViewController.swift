//
//  LoginViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, HandleLinkTap {
    
    func userDidSelectLink() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    private var backgroundView = BackgroundView(mainLabelText: "LOGIN")
    
    //TODO: Fix name
    private var signUpLink = AuthenticationLink(authenticationType: .login)
    
    private var socialMediaView = SocialMediaView()
    
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
    
    private var loginStack = AuthenticationForm(authenticationType: .login)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        

        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        createAccount.frame = CGRect(x: 16, y: view.bounds.midY + 72, width: view.bounds.width - 32, height: 52)
        createAccount.layer.cornerRadius = createAccount.bounds.height/2
        
        socialMediaView.frame = CGRect(x: 0, y: 2/3 * view.bounds.maxY, width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        let views = [backgroundView, createAccount, signUpLink, loginStack, socialMediaView]
        view.addMultipleSubviews(views)
        
        setConstraints()
        
        signUpLink.linkDelegate = self
    }
    
    func setConstraints() {
        setLoginStackConstraints()
        setSignUpLinkConstraints()
    }
    
    private func setSignUpLinkConstraints() {
        signUpLink.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLink.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
    
    private func setLoginStackConstraints() {
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            loginStack.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24)
        ])
    }

}
