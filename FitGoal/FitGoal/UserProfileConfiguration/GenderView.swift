//
//  GenderView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

class GenderView: UIView {
    let female = WalkthroughIconView(icon: WalkthroughIcon(iconType: .female))
    let male = WalkthroughIconView(icon: WalkthroughIcon(iconType: .male)) 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [female, male]
        
        addMultipleSubviews(views)
        setAxisConstraints()
        setDimensionConstraints(icons: views)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Contraints
    private func setAxisConstraints() {
        setFemaleAxisConstraints()
        setMaleAxisConstraints()
    }
    
    private func setDimensionConstraints(icons: [UIView]) {
        icons.forEach { (view) in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 152),
                view.widthAnchor.constraint(equalToConstant: 152)
            ])
        }
    }
    
    private func setFemaleAxisConstraints() {
        female.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            female.topAnchor.constraint(equalTo: self.topAnchor),
            female.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setMaleAxisConstraints() {
        male.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            male.topAnchor.constraint(equalTo: self.topAnchor),
            male.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
