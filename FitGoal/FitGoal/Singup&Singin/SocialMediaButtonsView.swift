//
//  SocialMediaButtonsView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SocialMediaView: UIView {
    
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
    private let loginStack = LoginLinkStack(questionText: "Already onboard?", linkText: "Login")
    
    private let socialMediaStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 50
        stack.distribution = .fill
        return stack
    }()
    
    private let googleButton: UIButton = {
        let googleButton = UIButton()
        googleButton.bounds.size = CGSize(width: 72, height: 72)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        socialMediaStack.addArrangedSubview(facebookButton)
        socialMediaStack.addArrangedSubview(googleButton)
        socialMediaStack.addArrangedSubview(twitterButton)
        
        let views = [socialMediaStack, dividerStack, loginStack]
        self.addMultipleSubviews(views)
        
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        socialMediaStack.layoutIfNeeded()
    }
    
    func setConstraints() {
        setDividerStackConstraints()
        setSocialMediaStackConstraints()
        setLoginStackConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDividerStackConstraints() {
        dividerStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dividerStack.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    private func setSocialMediaStackConstraints() {
        socialMediaStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            socialMediaStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            socialMediaStack.topAnchor.constraint(equalTo: self.dividerStack.bottomAnchor, constant: 50)
        ])
    }
    
    private func setLoginStackConstraints() {
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -72)
        ])
    }
    
   
}
