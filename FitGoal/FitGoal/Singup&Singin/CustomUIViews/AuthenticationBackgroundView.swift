//
//  BackgroundView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AuthenticationBackgroundView: UIView {
    
    private let gradientViewFrame = CGRect(x: 0, y: 0, width: 600, height: 812)
    
    private lazy var topLeftView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.customise(
            cornerRadius: 175,
            maskedCorners: [.layerMinXMaxYCorner],
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            alpha: 1
        )

        gradientView.transform(
            rotationAngle: -30,
            translationInX: 60,
            translationInY: -700
        )
        return gradientView
    }()
    
    private lazy var topRightView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 600, height: 812))
        gradientView.customise(
            cornerRadius: 175,
            maskedCorners: [.layerMaxXMaxYCorner],
            colors: [#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1), #colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1)],
            alpha: 0.43
        )
        
        gradientView.transform(
            rotationAngle: 23,
            translationInX: -350,
            translationInY: -550
        )
        
        return gradientView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [topLeftView, topRightView]
        self.addMultipleSubviews(views)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
