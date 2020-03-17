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
    
    private var checkIcon: UIImageView = {
        let logo = UIImageView(image: UIImage(imageLiteralResourceName: "icon_logo"))
        logo.frame = CGRect(x: 0, y: 0, width: 104, height: 104)
        return logo
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(gradientBackgroundView)
        view.addSubview(shadowWithGradient)
        view.addSubview(checkIcon)
    }
    
    
}
