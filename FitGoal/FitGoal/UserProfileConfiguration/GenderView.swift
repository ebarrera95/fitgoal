//
//  GenderView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

protocol GenderViewDelegate: AnyObject {
    func userDidSelectGender(gender: String)
}

class GenderView: UIView, WalkthroughIconViewDelegate {
    
    weak var delegate: GenderViewDelegate?
    
    private let female = WalkthroughIconView(icon: WalkthroughIcon(iconType: .female))
    private let male = WalkthroughIconView(icon: WalkthroughIcon(iconType: .male))
    
    private lazy var iconViews = [female, male]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addMultipleSubviews(iconViews)
        setAxisConstraints()
        setDimensionConstraints(icons: iconViews)
        setIconViewsDelegate()
    }
    
    required init?(coder: NSCoder) {
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
                delegate?.userDidSelectGender(gender: iconView.icon.name)
            } else {
                view.deselectView()
            }
        }
    }
    
    // MARK: -Contraints
    private func setAxisConstraints() {
        setFemaleAxisConstraints()
        setMaleAxisConstraints()
    }
    
    private func setDimensionConstraints(icons: [UIView]) {
        icons.forEach { (view) in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 162),
                view.widthAnchor.constraint(equalToConstant: 162)
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
