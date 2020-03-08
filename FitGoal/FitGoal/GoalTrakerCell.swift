//
//  GoalTrakerCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GoalTrakerCell: UICollectionViewCell {
    static var identifier = "GoalTraker"
    
    lazy var topView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 15, y: -650)
        return gradientView
    }()
    
    lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.attributedText = configureCellTitle(with: "my goal")
        return label
    }()

    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.attributedText = configureMonthLabel(with: "February")
        return label
    }()
    
    var imageAvatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(imageLiteralResourceName: "Avatar"))
        avatar.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        avatar.contentMode = .scaleAspectFill
        return avatar
    }()
    var addButton: UIButton = {
       let button = UIButton(type: .system)
        button.bounds = CGRect(x: 0, y: 0, width: 28, height: 28)
        button.setImage(UIImage(imageLiteralResourceName: "icons - System - Add"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    var goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "GoalTraker")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 10
        return imageView
    }()
    
    var shadowView: UIView = {
        var shadow = UIView()
        shadow.clipsToBounds = false
        //shadow.backgroundColor = .red
        shadow.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadow.layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowRadius = 10
        return shadow
    }()
    
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(topView)
        
        contentView.addSubview(shadowView)
        contentView.addSubview(monthLabel)
        contentView.addSubview(cellTitle)
        contentView.addSubview(imageAvatar)
        contentView.addSubview(addButton)
        
        shadowView.addSubview(goalImageView)
        
        
        setShadowConstraints()
        setMonthLabelConstrains()
        setcellTitleConstrains()
        setImageAvatarConstrains()
        setAddButtonConstrains()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goalImageView.frame = shadowView.bounds
    }
    
    //MARK: - Constrains
    
    private func setAddButtonConstrains() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addButton.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor)
        ])
    }
    
    private func setImageAvatarConstrains() {
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
    
    private func setMonthLabelConstrains() {
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    private func setcellTitleConstrains() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellTitle.bottomAnchor.constraint(equalTo: goalImageView.topAnchor, constant: -16),
            cellTitle.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 8)
        ])
    }
    
    
    //MARK: -TextConfiguration
    
    private func configureCellTitle(with string: String) -> NSAttributedString {
        let capString = string.localizedUppercase
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Oswald-Medium", size: 34)!,
            .foregroundColor: UIColor.white,
            .kern: -0.12
        ]
        let cellTitle = NSAttributedString(string: capString, attributes: atributes)
        return cellTitle
    }
    private func configureMonthLabel(with string: String) -> NSAttributedString {
        //let capString = string.localizedUppercase
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Roboto-Regular", size: 15)!,
            .foregroundColor: UIColor.white,
            .kern: 0.18
        ]
        let cellTitle = NSAttributedString(string: string, attributes: atributes)
        return cellTitle
    }
}
