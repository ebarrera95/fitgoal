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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [gradientBackgroundView, shadowWithGradient]
        self.addMultipleSubviews(views)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
