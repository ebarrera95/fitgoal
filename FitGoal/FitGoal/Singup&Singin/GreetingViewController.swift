//
//  GreetingViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController, HandleLinkTap {
    
    private var backgroundView = BackgroundView(mainLabelText: "HELLO")
    
    private var socialMediaView = SocialMediaView()
    
    private var loginLink = AutenticationLink(autenticationType: .login)
    
    private var createAccount: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        let title = "Create Account".formattedText(font: "Roboto-Bold", size: 17, color: .white, kern: 0)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private var text: UITextView = {
        let text = UITextView()
        let string = "Start transforming the way \n you enjoy you life"
        let attributedString = string.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
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
        
        backgroundView.frame = CGRect(x: 0, y: 0,  width: view.bounds.width, height: 1/3 * view.bounds.height + 50)
        socialMediaView.frame = CGRect(x: 0, y: 2/3 * view.bounds.maxY, width: view.bounds.width, height: 1/3 * view.bounds.height)
        
        createAccount.frame = CGRect(x: 16, y: view.bounds.midY + 50, width: view.bounds.width - 32, height: 52)
        createAccount.layer.cornerRadius = createAccount.bounds.height/2
        
        let views = [backgroundView, socialMediaView, createAccount, text, loginLink]
        view.addMultipleSubviews(views)
        
        setTextConstraints()
        setLoginStackConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        createAccount.addGestureRecognizer(tap)
        
        loginLink.linkDelegate = self
        
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let singupVC = SignUpViewController()
            singupVC.modalPresentationStyle = .fullScreen
            singupVC.modalTransitionStyle = .crossDissolve
            show(singupVC, sender: self)
        default:
            return
        }
    }
    
    func userDidSelectLink() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        show(vc, sender: self)
    }
    
    private func setTextConstraints() {
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setLoginStackConstraints() {
        loginLink.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLink.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
}
