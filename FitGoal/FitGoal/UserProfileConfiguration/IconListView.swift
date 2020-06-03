//
//  IconListView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 23/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol IconListViewDelegate: AnyObject {
    func iconListView(_ listView: IconListView, didSelectIcon iconView: WalkthroughIconView)
    func iconListView(_ listView: IconListView, didDeselectIcon iconView: WalkthroughIconView)
}

class IconListView: UIView {
    
    weak var delegate: IconListViewDelegate?
    
    private var iconList: [WalkthroughIconView]
    private let iconDimension: CGFloat = 162
    
    init(iconList: [WalkthroughIconView]) {
        self.iconList = iconList
        super.init(frame: .zero)
        self.addMultipleSubviews(self.iconList)
        setDimensionConstraints(icons: self.iconList)
        setAxisConstraints(for: self.iconList)
        addGestureRecogniser(toViews: self.iconList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGestureRecogniser(toViews views: [WalkthroughIconView]) {
        views.forEach { (view) in
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let item = sender.view as? WalkthroughIconView else { return }
        
        if !item.isSelected {
            delegate?.iconListView(self, didSelectIcon: item)
        } else {
            delegate?.iconListView(self, didDeselectIcon: item)
        }
        
        item.isSelected = !item.isSelected
        for iconView in iconList where iconView != item {
            iconView.isSelected = false
        }
    }
    
    private func setDimensionConstraints(icons: [UIView]) {
        icons.forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: iconDimension),
                view.widthAnchor.constraint(equalToConstant: iconDimension)
            ])
        }
    }
    
    private func setAxisConstraints(for icons: [UIView]) {
        for index in icons.indices {
            let iconView = icons[index]
            if index % 2 == 0 {
                iconView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            } else {
                iconView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            }
            
            if index == 0 || index == 1 {
                iconView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            } else {
                let iconViewOnTop = icons[index - 2]
                iconView.topAnchor.constraint(equalTo: iconViewOnTop.bottomAnchor, constant: 16).isActive = true
            }
        }
    }
}
