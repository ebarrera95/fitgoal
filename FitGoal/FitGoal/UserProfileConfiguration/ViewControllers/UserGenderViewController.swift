//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserGenderViewController: UIViewController {
    
    private let genderChooserView = GenderView()
    
    let questionPrefix = "What is"
    let questionSuffix = "YOUR GENDER?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        
        let views = [
            genderChooserView
        ]
        view.addMultipleSubviews(views)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        genderChooserView.frame = CGRect(x: 0, y: 0, width: 320, height: 152)
        genderChooserView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
    }

}
