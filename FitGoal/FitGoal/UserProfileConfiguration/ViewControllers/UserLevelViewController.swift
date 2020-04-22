//
//  UserLevelViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 22/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserLevelViewController: UIViewController {
    
    private var bodyLevelChooserView = BodyLevelView()
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -130, y: -250)
        return gradientView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(gradientBackgroundView)
        view.addSubview(bodyLevelChooserView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bodyLevelChooserView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        bodyLevelChooserView.center = view.center
    }
}
