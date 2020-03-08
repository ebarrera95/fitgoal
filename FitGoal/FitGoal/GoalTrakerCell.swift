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

    var monthLable = UILabel()
    
    var imageAvatar = UIImageView()
    var addButton = UIButton()
    
    
    var goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "GoalTraker")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(topView)
        contentView.addSubview(goalImageView)
        setGoalImageConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Constrains
    private func setGoalImageConstraints() {
        goalImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goalImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            goalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            goalImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            goalImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func setMonthLabelConstrains() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = true
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
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
}
