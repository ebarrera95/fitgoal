//
//  HelloViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 17/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {
    
    private let gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 175
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -30 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 60, y: -700)
        return gradientView
    }()
    
    private let shadowWithGradient: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 400, height: 812))
        gradientView.layer.cornerRadius = 175
        gradientView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1), #colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1)]
        gradientView.alpha = 0.43
        let rotation = CGAffineTransform(rotationAngle: 23 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -150, y: -600)
        return gradientView
    }()
    
    private let checkIcon = UIImageView(image: UIImage(imageLiteralResourceName: "icon_logo"))
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        let text = "HELLO!".formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: #colorLiteral(red: 0.36, green: 0.37, blue: 0.4, alpha: 1),
            kern: -0.12)
        label.attributedText = text
        return label
    }()
    
    private let googleButton: UIButton = {
        let googleButton = UIButton()
        googleButton.bounds.size = CGSize(width: 80, height: 80)
        googleButton.layer.cornerRadius = 40
        googleButton.contentMode = .scaleAspectFit
        googleButton.setImage(#imageLiteral(resourceName: "GoogleButton"), for: .normal)
        googleButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        googleButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01)
        googleButton.layer.shadowOpacity = 1
        googleButton.layer.shadowRadius = 5
        return googleButton
    }()

    private var facebookButton: UIButton = {
        let facebookButton = UIButton()
        facebookButton.bounds.size = CGSize(width: 72, height: 72)
        facebookButton.layer.cornerRadius = 40
        facebookButton.contentMode = .scaleAspectFit
        facebookButton.setImage(#imageLiteral(resourceName: "FacebookButton"), for: .normal)
        return facebookButton
    }()

    private var twitterButton: UIButton = {
        let twitterButton = UIButton()
        twitterButton.bounds.size = CGSize(width: 72, height: 72)
        twitterButton.layer.cornerRadius = 40
        twitterButton.contentMode = .scaleAspectFit
        twitterButton.setImage(#imageLiteral(resourceName: "TwitterButton"), for: .normal)
        return twitterButton
    }()
    
    private var question: UILabel = {
        let label = UILabel()
        let attributedString = "Already onboard?".formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
        
        label.attributedText = attributedString
        label.tag = 0
        return label
    }()

    private var loginLink: UIButton = {
        let button = UIButton()
        let attributedText = "Login".formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
            kern: 0
        )
        
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
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
    
    private let loginStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    private let socialMediaStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 50
        stack.distribution = .fill
        return stack
    }()
    
    private let dividerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 16
        
        let leadingLine = UIView()
        leadingLine.layer.borderColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
        leadingLine.layer.borderWidth = 1
        
        let trailingLine = UIView()
        trailingLine.layer.borderColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
        trailingLine.layer.borderWidth = 1
        
        let label = UILabel()
        label.attributedText = "Or".formattedText(font: "Roboto-Light",size: 15, color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1), kern: 0)
        
        stack.addArrangedSubview(leadingLine)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(trailingLine)
        
        leadingLine.widthAnchor.constraint(equalToConstant: 130).isActive = true
        leadingLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        trailingLine.widthAnchor.constraint(equalToConstant: 130).isActive = true
        trailingLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        let views = [
            gradientBackgroundView,
            shadowWithGradient,
            checkIcon,
            greetingLabel,
            socialMediaStack,
            createAccount,
            text,
            loginStack,
            dividerStack
        ]
        
        view.addMultipleSubviews(views)
        
        loginStack.addArrangedSubview(question)
        loginStack.addArrangedSubview(loginLink)
        
        socialMediaStack.addArrangedSubview(facebookButton)
        socialMediaStack.addArrangedSubview(googleButton)
        socialMediaStack.addArrangedSubview(twitterButton)
        
        setConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        createAccount.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let singupVC = SignUpViewController()
            singupVC.modalPresentationStyle = .fullScreen
            show(singupVC, sender: self)
        default:
            return
        }
    }
    
    func setConstraints(){
        setGreetingLabelConstraints()
        setTextConstraints()
        setLoginStackConstraints()
        setSocialMediaStackConstraints()
        setDividerStackConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkIcon.frame = CGRect(x: view.bounds.midX - 52, y: 130, width: 104, height: 104)
        
        createAccount.frame = CGRect(x: 16, y: view.bounds.midY + 50, width: view.bounds.width - 32, height: 52)
        createAccount.layer.cornerRadius = createAccount.bounds.height/2
        
    }
    
    
    
    // MARK: -Constraints
    
    private func setGreetingLabelConstraints(){
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: text.topAnchor, constant: -50)
        ])
    }
    
    private func setTextConstraints() {
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setLoginStackConstraints() {
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
    
    private func setSocialMediaStackConstraints() {
        socialMediaStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            socialMediaStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            socialMediaStack.bottomAnchor.constraint(equalTo: loginStack.topAnchor, constant: -50)
        ])
    }
    
    private func setDividerStackConstraints() {
        dividerStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerStack.bottomAnchor.constraint(equalTo: socialMediaStack.topAnchor, constant: -50)
        ])
    }
}
