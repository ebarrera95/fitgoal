//
//  GradientView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    var colors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
}

extension GradientView {
    
    func customiseGradientView(
        cornerRadius: CGFloat,
        maskedCorners: CACornerMask,
        colors: [UIColor],
        alpha: CGFloat)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        self.colors = colors
        self.alpha = alpha
    }
    
    func transformGradientView(
        rotationAngle: CGFloat,
        translationInX: CGFloat,
        translationInY: CGFloat)
    {
        let rotation = CGAffineTransform(rotationAngle: rotationAngle / 180 * CGFloat.pi)
        self.transform =  rotation.translatedBy(x: translationInX, y: translationInY)
    }
}
