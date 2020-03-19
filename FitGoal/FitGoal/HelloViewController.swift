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
        let button = UIButton()
        button.bounds.size = CGSize(width: 80, height: 80)
        button.layer.cornerRadius = 40
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "GoogleButton"), for: .normal)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowColor = UIColor(r: 0, g: 0, b: 0, a: 0.1).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        return button
    }()
    
    private var facebookButton: UIButton = {
        let button = UIButton()
        button.bounds.size = CGSize(width: 72, height: 72)
        button.layer.cornerRadius = 40
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "FacebookButton"), for: .normal)
        return button
    }()
    
    private var twitterButton: UIButton = {
        let button = UIButton()
        button.bounds.size = CGSize(width: 72, height: 72)
        button.layer.cornerRadius = 40
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "TwitterButton"), for: .normal)
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(gradientBackgroundView)
        view.addSubview(shadowWithGradient)
        view.addSubview(checkIcon)
        view.addSubview(greetingLabel)
        
        view.addSubview(facebookButton)
        view.addSubview(googleButton)
        view.addSubview(twitterButton)
        
        setGreetingLabelConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkIcon.frame = CGRect(x: view.bounds.midX - 52, y: 130, width: 104, height: 104)
        
        googleButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY - 200)
        facebookButton.center = CGPoint(x: view.bounds.midX/2, y: view.bounds.maxY - 200)
        twitterButton.center = CGPoint(x: 3/2 * view.bounds.midX, y: view.bounds.maxY - 200)
    }
    
    private func setGreetingLabelConstraints(){
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
    
    
}
