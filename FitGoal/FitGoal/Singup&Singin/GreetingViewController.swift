//
//  GreetingViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController, AuthenticationTypeDelegate {
    
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
    
    private let avatarManager = AvatarManager(authenticationType: .none)
    
    private let backgroundView = BackgroundView ()
    
    private let socialMediaView = SocialMediaAuthentication()
    
    private let connectionToLoginVC = AuthenticationLink(authenticationType: .signUp)
    
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
        
        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height)
        socialMediaView.frame = CGRect(x: 0, y: 2/3 * view.bounds.maxY, width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        createAccountButton.frame = CGRect(x: 16, y: view.bounds.midY + 50, width: view.bounds.width - 32, height: 52)
        createAccountButton.layer.cornerRadius = createAccountButton.bounds.height/2
        
        let views = [backgroundView, avatarManager, mainLabel, socialMediaView, createAccountButton, greetingText, connectionToLoginVC]
        view.addMultipleSubviews(views)
        
        setConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(createAccountTap(_:)))
        createAccountButton.addGestureRecognizer(tap)
        
        connectionToLoginVC.delegate = self
    }

    @objc func createAccountTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let vc = SignUpViewController()
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
        connectionToLoginVC.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            connectionToLoginVC.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectionToLoginVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
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
