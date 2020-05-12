//
//  BodyLevelView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 22/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol FitnessLevelChooserViewDelegate: AnyObject {
    func userDidSelectFitnessLevel(level: String)
}

class FitnessLevelChooserView: UIView, WalkthroughIconViewDelegate {
    
    weak var delegate: FitnessLevelChooserViewDelegate?
    
    private let skinnyBody = WalkthroughIconView(icon: WalkthroughIcon(iconType: .skinny))
    private let normalBody = WalkthroughIconView(icon: WalkthroughIcon(iconType: .normal))
    private let obeseBody = WalkthroughIconView(icon: WalkthroughIcon(iconType: .obese))
    private let athleticBody = WalkthroughIconView(icon: WalkthroughIcon(iconType: .athletic))
    
    private lazy var iconViews = [skinnyBody, normalBody, obeseBody, athleticBody]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addMultipleSubviews(iconViews)
        setAxisConstraints()
        setDimensionConstraints(icons: iconViews)
        setIconViewsDelegate()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setIconViewsDelegate() {
        iconViews.forEach { (view) in
            view.delegate = self
        }
    }
    
    func userDidSelectIcon(iconView: WalkthroughIconView) {
        for view in iconViews {
            if view == iconView {
                delegate?.userDidSelectFitnessLevel(level: iconView.icon.name)
            } else {
                view.deselectView()
            }
        }
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
                view.heightAnchor.constraint(equalToConstant: 162),
                view.widthAnchor.constraint(equalToConstant: 162)
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
