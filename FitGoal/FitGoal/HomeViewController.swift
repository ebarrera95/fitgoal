//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureBackgroundView()
    }
}

extension HomeViewController {
    private func configureBackgroundView() {
         view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
         let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 550, height: 812))
         backgroundView.layer.masksToBounds = true
         backgroundView.layer.cornerRadius = 150
         backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner]
         backgroundView.transform = backgroundView.transform.rotated(by: -0.4537856055185257)
         backgroundView.transform = backgroundView.transform.translatedBy(x: 10, y: -600)

         view.addSubview(backgroundView)
         createGradient(in: backgroundView)
     }

     private func createGradient(in view: UIView) {
         let gradient = CAGradientLayer()
         gradient.frame = view.bounds
         let fistColour = #colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1)
         let secondColour = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
         gradient.colors = [fistColour.cgColor, secondColour.cgColor]
         gradient.locations = [0, 1]
         view.layer.insertSublayer(gradient, at: 0)
     }
}

