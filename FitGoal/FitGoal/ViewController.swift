//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gradientLayer: CAGradientLayer?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //backgroudGradient = configureGradient()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradientLayer = createGradient()
        
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
        
    }
    
    
    func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        
        let fistColour = #colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1)
        let secondColour = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        
        gradient.colors = [fistColour.cgColor, secondColour.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        return gradient
    }

}

