//
//  BodyLevelView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 22/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class BodyLevelView: UIView {
    
    let skinnyBody = IconBuilderView(icon: IconBuilder(icon: .skinny))
    let normalBody = IconBuilderView(icon: IconBuilder(icon: .normal))
    let obeseBody = IconBuilderView(icon: IconBuilder(icon: .obese))
    let athleticBody = IconBuilderView(icon: IconBuilder(icon: .athletic))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [
            skinnyBody,
            normalBody,
            obeseBody,
            athleticBody
        ]
        addMultipleSubviews(views)
        setAxisConstraints()
        setDimensionConstraints(icons: views)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func setAxisConstraints() {
        setSkinnyBodyAxisConstraints()
        setNormalBodyAxisConstraints()
        setAthleticBodyAxisConstraints()
        setObeseBodyAxisConstraints()
    }
    
    private func setDimensionConstraints(icons: [UIView]) {
        icons.forEach { (view) in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 152),
                view.widthAnchor.constraint(equalToConstant: 152)
            ])
        }
    }
    
    private func setSkinnyBodyAxisConstraints() {
        skinnyBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinnyBody.topAnchor.constraint(equalTo: self.topAnchor),
            skinnyBody.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setNormalBodyAxisConstraints() {
        normalBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            normalBody.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            normalBody.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setObeseBodyAxisConstraints() {
        obeseBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            obeseBody.topAnchor.constraint(equalTo: self.topAnchor),
            obeseBody.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setAthleticBodyAxisConstraints() {
        athleticBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            athleticBody.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            athleticBody.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
