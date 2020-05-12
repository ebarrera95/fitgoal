//
//  ExercisePlayerViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExercisePlayerViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ExerciseBackgroundView(frame: self.view.frame))
    }
}

class ExerciseBackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addMultipleSubviews(generateBackgroundView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateGradientView(cornerRadius: CGFloat, maskedCorners: CACornerMask, colors: [UIColor], rotationAngle: CGFloat, translationInX: CGFloat, translationInY: CGFloat, alpha: CGFloat) -> UIView {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 600, height: 812))
        gradientView.layer.cornerRadius =  cornerRadius
        gradientView.layer.maskedCorners = maskedCorners
        gradientView.colors = colors
        let rotation = CGAffineTransform(rotationAngle: rotationAngle / 180 * CGFloat.pi)
        gradientView.alpha = alpha
        gradientView.transform = rotation.translatedBy(x: translationInX, y: translationInY)
        return gradientView
    }
    
    private func generateBackgroundView() -> [UIView]  {
        let gradientBackgroundView: UIView = {
            let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
            gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
            return gradientView
        }()
        
        let topLeftGradientView = generateGradientView(
            cornerRadius: 175,
            maskedCorners: .layerMinXMaxYCorner,
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            rotationAngle: -30,
            translationInX: 60,
            translationInY: -730,
            alpha: 0.1
        )
        
        let topRightGradientView = generateGradientView(
            cornerRadius: 175,
            maskedCorners: .layerMaxXMaxYCorner,
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            rotationAngle: 35,
            translationInX: -350,
            translationInY: -630,
            alpha: 0.25
        )
        
        let bottomRightGradientView = generateGradientView(
            cornerRadius: 130,
            maskedCorners: .layerMinXMinYCorner,
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            rotationAngle: 60,
            translationInX: 620,
            translationInY: 450,
            alpha: 0.70
        )
        
        return [gradientBackgroundView, topLeftGradientView, topRightGradientView, bottomRightGradientView]
    }
}
