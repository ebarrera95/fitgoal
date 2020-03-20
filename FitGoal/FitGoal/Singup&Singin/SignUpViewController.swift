//
//  SignUpViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var backgroundView = BackgroundView(mainLabelText: "SIGNUP")
    
    private var loginStack = LoginLinkStack(questionText: "Already onboard?", linkText: "Login")
    
    private var createAccount: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        let title = "Create Account".formattedText(font: "Roboto-Bold", size: 17, color: .white, kern: 0)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private var signUpStack = SignUpForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)

        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        createAccount.frame = CGRect(x: 16, y: view.bounds.maxY - 200, width: view.bounds.width - 32, height: 52)
        createAccount.layer.cornerRadius = createAccount.bounds.height/2
        
        let views = [backgroundView, createAccount, loginStack, signUpStack]
        view.addMultipleSubviews(views)
        
        setConstraints()
    }
    
    func setConstraints() {
        setLoginStackConstraints()
        setSingUpStackConstraints()
    }
    
    private func setLoginStackConstraints() {
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
    
    private func setSingUpStackConstraints() {
        signUpStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signUpStack.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24)
        ])
    }
}
