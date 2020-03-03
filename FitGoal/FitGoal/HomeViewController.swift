//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var topView: UIView!
    var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        gradient = createGradient()
        topView.layer.addSublayer(gradient)
        
        self.view.addSubview(topView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = topView.bounds
    }
}

extension HomeViewController {
    private func configureBackground() {
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 812))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 150
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        let transform = rotation.translatedBy(x: 10, y: -600)
        view.transform = transform
        self.topView = view
    }
    
    private func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let fistColour = #colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1)
        let secondColour = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        gradient.colors = [fistColour.cgColor, secondColour.cgColor]
        gradient.locations = [0, 1]
        return gradient
    }
}

