//
//  ExercisePlayerBackgroundView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 6/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExercisePlayerBackgroundView: UIView {
    
    private let colours = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
    private let gradientViewFrame = CGRect(x: 0, y: 0, width: 600, height: 812)
    
    private lazy var topLeftView: GradientView = {
        let gradientView = GradientView(frame: gradientViewFrame)
        gradientView.customise(
            cornerRadius: 175,
            maskedCorners: .layerMinXMaxYCorner,
            colors: colours,
            alpha: 0.1
        )
        gradientView.transform(
            rotationAngle: -30,
            translationInX: 60,
            translationInY: -730
        )
        return gradientView
    }()
    
    private lazy var topRightView: GradientView = {
        let gradientView = GradientView(frame: gradientViewFrame)
        gradientView.customise(
            cornerRadius: 175,
            maskedCorners: .layerMaxXMaxYCorner,
            colors: colours,
            alpha: 0.25
        )
        gradientView.transform(
            rotationAngle: 35,
            translationInX: -350,
            translationInY: -630
        )
        return gradientView
    }()
    
    private lazy var bottomLeftView: GradientView = {
        let gradientView = GradientView(frame: gradientViewFrame)
        gradientView.customise(
            cornerRadius: 130,
            maskedCorners: .layerMinXMinYCorner,
            colors: colours,
            alpha: 0.70
        )
        gradientView.transform(
            rotationAngle: 60,
            translationInX: 620,
            translationInY: 450
        )
        return gradientView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let background = GradientView(frame: frame)
        background.colors = colours
        addSubview(background)
        
        addMultipleSubviews([
            topLeftView,
            topRightView,
            bottomLeftView
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
