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
    
    let questionPrefix = "What is your current  fitness"
    let questionSuffix = "LEVEL?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        
        let views = [
            bodyLevelChooserView
        ]
        view.addMultipleSubviews(views)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bodyLevelChooserView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        bodyLevelChooserView.center = CGPoint(x: view.center.x, y: view.center.y + 50)
    }
}
