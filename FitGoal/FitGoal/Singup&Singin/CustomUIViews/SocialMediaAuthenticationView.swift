//
//  SocialMediaButtonsView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SocialMediaAuthenticationView: UIView {
    
    private let dividerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 16
        
        let leadingLine = UIView()
        leadingLine.layer.borderColor = #colorLiteral(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
        leadingLine.layer.borderWidth = 1
        
        let trailingLine = UIView()
        trailingLine.layer.borderColor = #colorLiteral(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
        trailingLine.layer.borderWidth = 1
        
        let label = UILabel()
        label.attributedText = "Or".formattedText(
            font: "Roboto-Light",
            size: 15,
            color: #colorLiteral(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
        
        stack.addArrangedSubview(leadingLine)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(trailingLine)
        
        NSLayoutConstraint.activate([
            leadingLine.widthAnchor.constraint(equalToConstant: 130),
            leadingLine.heightAnchor.constraint(equalToConstant: 2),
            trailingLine.widthAnchor.constraint(equalToConstant: 130),
            trailingLine.heightAnchor.constraint(equalToConstant: 2)
        ])
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
    
    private lazy var googleButton: UIButton = {
        let googleButton = socialMediaButton()
        googleButton.setImage(#imageLiteral(resourceName: "GoogleButton"), for: .normal)
        googleButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        googleButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01)
        googleButton.layer.shadowRadius = 5
        return googleButton
    }()

    private lazy var facebookButton: UIButton = {
        let facebookButton = socialMediaButton()
        facebookButton.setImage(#imageLiteral(resourceName: "FacebookButton"), for: .normal)
        return facebookButton
    }()

    private lazy var twitterButton: UIButton = {
        let twitterButton = socialMediaButton()
        twitterButton.setImage(#imageLiteral(resourceName: "TwitterButton"), for: .normal)
        return twitterButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        socialMediaStack.addArrangedSubview(facebookButton)
        socialMediaStack.addArrangedSubview(googleButton)
        socialMediaStack.addArrangedSubview(twitterButton)
        
        let views = [socialMediaStack, dividerStack]
        self.addMultipleSubviews(views)
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        socialMediaStack.layoutIfNeeded()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func socialMediaButton() -> UIButton {
        let button = UIButton()
        button.bounds.size = CGSize(width: 72, height: 72)
        button.layer.cornerRadius = 40
        button.contentMode = .scaleAspectFit
        return button
    }
    
    // MARK: -Constraints
    
    func setConstraints() {
        setDividerStackConstraints()
        setSocialMediaStackConstraints()
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
}
