//
//  BackgroundView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 175
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -30 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 60, y: -700)
        return gradientView
    }()
    
    var shadowWithGradient: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 400, height: 812))
        gradientView.layer.cornerRadius = 175
        gradientView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1), #colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1)]
        gradientView.alpha = 0.43
        let rotation = CGAffineTransform(rotationAngle: 23 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -150, y: -600)
        return gradientView
    }()
    
    var avatarIcon = UIButton()
    
    var mainLabel = UILabel()
    
    convenience init(mainLabelText: String, avatarImage: UIImage, authenticationType: AuthenticationType) {
        self.init(frame: .zero)
        let text = mainLabelText.formattedText(
        font: "Oswald-Medium",
        size: 34,
        color: #colorLiteral(red: 0.36, green: 0.37, blue: 0.4, alpha: 1),
        kern: -0.12)
        mainLabel.attributedText = text
        
        switch authenticationType.self {
        case .signUp:
            avatarIcon.setImage(avatarImage, for: .normal)
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            avatarIcon.addGestureRecognizer(tap)
        default:
            avatarIcon.isUserInteractionEnabled = false
            avatarIcon.setImage(avatarImage, for: .normal)
            return
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            return
        default:
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [gradientBackgroundView, shadowWithGradient, avatarIcon, mainLabel]
        self.addMultipleSubviews(views)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarIcon.frame = CGRect(x: bounds.midX - 52, y: 130, width: 104, height: 104)
    }
    
    func setConstraints() {
        setMainLabelConstraints()
    }
    
    func setMainLabelConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
