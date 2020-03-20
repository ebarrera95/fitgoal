//
//  GreetingViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController {
    
    lazy var backgroundView = BackgroundView(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        let views = [backgroundView]
        view.addMultipleSubviews(views)
        
    }
}
