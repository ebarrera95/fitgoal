//
//  HelloViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 17/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 15, y: -650)
        return gradientView
    }()
    
    
}
