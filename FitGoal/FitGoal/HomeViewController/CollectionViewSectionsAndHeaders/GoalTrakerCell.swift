//
//  GoalTrakerCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GoalTrakerCell: UICollectionViewCell {
    
    static let identifier = "GoalTraker"
    
    private var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.customise(
            cornerRadius: 150,
            maskedCorners: [.layerMinXMaxYCorner],
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            alpha: 1
        )
        gradientView.transform(
            rotationAngle: -26,
            translationInX: 15,
            translationInY: -650
        )
        return gradientView
    }()
    
    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.attributedText = "MY GOAL".formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: .white,
            kern: -0.14
        )
        return label
    }()

    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "February".formattedText (
            font: "Roboto-Regular",
            size: 15,
            color: .white,
            kern: 0.18
        )
        return label
    }()
    
    private var imageAvatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(imageLiteralResourceName: "Avatar"))
        avatar.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        avatar.contentMode = .scaleAspectFill
        return avatar
    }()
    
    private var addButton: UIButton = {
       let button = UIButton(type: .system)
        button.bounds = CGRect(x: 0, y: 0, width: 28, height: 28)
        button.setImage(UIImage(imageLiteralResourceName: "icons - System - Add"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private var goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "GoalTraker")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var shadowView: UIView = {
        var shadow = UIView()
        shadow.clipsToBounds = false
        shadow.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadow.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowRadius = 10
        return shadow
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(gradientBackgroundView)
        
        let subviews = [shadowView, monthLabel, cellTitle, imageAvatar, addButton]
        addSubviewsToContentView(views: subviews)
        
        shadowView.addSubview(goalImageView)
        
        setConstraints()
    }
    
    private func addSubviewsToContentView(views: [UIView]) {
        views.forEach { view in
            self.contentView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        setShadowConstraints()
        setMonthLabelConstraints()
        setcellTitleConstraints()
        setImageAvatarConstraints()
        setAddButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goalImageView.frame = shadowView.bounds
    }
    
    //MARK: - Constraints
    
    private func setAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addButton.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor)
        ])
    }
    
    private func setImageAvatarConstraints() {
        imageAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageAvatar.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor)
        ])
    }
    
    private func setShadowConstraints() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setMonthLabelConstraints() {
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    private func setcellTitleConstraints() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellTitle.bottomAnchor.constraint(equalTo: goalImageView.topAnchor, constant: -16),
            cellTitle.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 8)
        ])
    }
}
