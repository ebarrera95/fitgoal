//
//  RoutineSectionHeader.swift
//  FitGoal
//
//  Created by Eliany Barrera on 6/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class RoutineSectionHeader: UICollectionReusableView {
    
    static var identifier = "RoutineCellHeader"
    
    var sectionName: String? {
        didSet {
            if let string = sectionName {
                headerLabel.attributedText = string.uppercased().formattedText(
                    font: "Oswald-Medium",
                    size: 16,
                    color: UIColor(r: 98, g: 99, b: 99, a: 100),
                    kern: 0.17
                )
            } else {
                headerLabel.attributedText = nil
            }
        }
    }
    
    lazy var link: UIButton = {
        let linkButton = UIButton(type: .system)
        let attributedText = "See All".formattedText(
            font: "Roboto-Regular",
            size: 14,
            color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
            kern: 0.1
        )
        
        linkButton.setAttributedTitle(attributedText, for: .normal)
        return linkButton
    }()
    
    private var headerLabel = UILabel()
    
    private var backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundView)
        backgroundView.addSubview(headerLabel)
        backgroundView.addSubview(link)
        layoutHeaderLabel()
        layoutLink()
        
        link.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
    }
    
    @objc private func handleTouch() {
        print("handling touch!")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = self.bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sectionName = nil
        link.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -12),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor)
        ])
    }
    
    private func layoutLink() {
        link.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            link.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            link.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
    }
}
