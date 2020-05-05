//
//  SettingHeaderView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SettingHeaderView: UIView {
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
        gradientView.layer.cornerRadius = 75
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let translation = CGAffineTransform(translationX: 0, y: -350)
        gradientView.transform = translation
        return gradientView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "settings".uppercased().formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: .white,
            kern: 0.12
        )
        return label
    }()
    
    private let userNameLabel = UILabel()
    private let userFitnessLevelLabel = UILabel()
    
    private let userAvatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 8
        view.image = UIImage(imageLiteralResourceName: "Avatar")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let editProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "editProfile")
        return imageView
    }()
    
    convenience init(frame: CGRect, userName: String, userFitnessLevel: String, userProfileImage: UIImage?) {
        self.init(frame: frame)
        configureUserNameLabel(withText: userName)
        configureUserFitnessLabelLevel(withText: userFitnessLevel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [
            gradientBackgroundView,
            mainTitleLabel,
            userNameLabel,
            userFitnessLevelLabel,
            userAvatarImageView,
            editProfileImageView
        ]
        self.addMultipleSubviews(views)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height/2
    }
    
    private func configureUserNameLabel(withText text: String) {
        userNameLabel.attributedText = text.uppercased().formattedText(font: "Oswald-Medium", size: 14, color: .white, kern: 0.17)
    }
    
    private func configureUserFitnessLabelLevel(withText text: String) {
        userFitnessLevelLabel.attributedText = text.formattedText(font: "Roboto-Light", size: 14, color: .white, kern: 0.17)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        setMainLabelConstraints()
        setUserAvatarConstraints()
        setEditProfileConstraints()
        setUserFitnessLevelConstraints()
        setUserNameConstraints()
    }
    
    private func setMainLabelConstraints() {
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
        ])
    }
    
    private func setUserAvatarConstraints() {
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userAvatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userAvatarImageView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 100),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setEditProfileConstraints() {
        editProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editProfileImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            editProfileImageView.centerYAnchor.constraint(equalTo: mainTitleLabel.centerYAnchor, constant: -4),
            editProfileImageView.widthAnchor.constraint(equalToConstant: 26),
            editProfileImageView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func setUserFitnessLevelConstraints() {
        userFitnessLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userFitnessLevelLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 16),
            userFitnessLevelLabel.centerYAnchor.constraint(equalTo: userAvatarImageView.centerYAnchor)
        ])
    }
    
    private func setUserNameConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 16),
            userNameLabel.bottomAnchor.constraint(equalTo: userFitnessLevelLabel.topAnchor, constant: -4)
        ])
    }
    
}
