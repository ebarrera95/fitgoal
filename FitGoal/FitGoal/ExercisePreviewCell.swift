//
//  ExercisePreviewCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExercisePreviewCell: UICollectionViewCell {
    
    static var identifier = "Exercise Preview"
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 15, y: -650)
        return gradientView
    }()
    
    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "GoalTraker")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.attributedText = "WALKING LUNGES".formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: .white,
            kern: -0.14
        )
        return label
    }()
    
    private var shadowView: UIView = {
        var shadow = UIView()
        shadow.backgroundColor = .blue
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
        
        let views = [shadowView, placeholder, cellTitle]
        addSubviewsToContentView(views: views)
        
        shadowView.addSubview(backgroundImage)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = shadowView.bounds
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setShadowConstraints()
    }
    
    private func addSubviewsToContentView(views: [UIView]) {
        views.forEach { view in
            self.contentView.addSubview(view)
        }
    }
    //MARK: - Constraints
    
    private func setTitleLabelConstraints() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            cellTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
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
    

}
