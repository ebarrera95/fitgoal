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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(gradientBackgroundView)
        view.addSubview(shadowWithGradient)
        view.addSubview(checkIcon)
        view.addSubview(greetingLabel)
        
        setGreetingLabelConstraints()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkIcon.frame = CGRect(x: view.bounds.midX - 52, y: 130, width: 104, height: 104)
    }
    
    private func setGreetingLabelConstraints(){
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
    
}
