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
                headerLabel.attributedText = formatted(header: string)
            } else {
                headerLabel.attributedText = nil
            }
        }
    }
    
    private lazy var link: UILabel = {
        let linkLabel = UILabel()
        linkLabel.attributedText = formatted(link: "See All")
        return linkLabel
    }()
    
    private var headerLabel = UILabel()
    private var backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundView)
        backgroundView.addSubview(headerLabel)
        backgroundView.addSubview(link)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackgroundView()
        layoutHeaderLabel()
        layoutLink()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sectionName = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  16),
            backgroundView.widthAnchor.constraint(equalToConstant: self.bounds.size.width - 32),
            backgroundView.heightAnchor.constraint(equalToConstant: self.bounds.size.height)
        ])
    }
    
    private func layoutHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor)
        ])
    }
    
    private func layoutLink() {
        link.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            link.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            link.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
    }
    
    private func formatted(link: String) -> NSAttributedString {
        return NSAttributedString(
            string: link,
            attributes: [
                .font: UIFont(name: "Roboto-Regular", size: 14)!,
                .foregroundColor: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
                .kern: 0.1
            ]
        )
    }
    
    private func formatted(header: String) -> NSAttributedString {
        return NSAttributedString(
            string: header.localizedUppercase,
            attributes: [
                .font: UIFont(name: "Oswald-Medium", size: 16)!,
                .foregroundColor: UIColor(r: 98, g: 99, b: 99, a: 100),
                .kern: 0.17
            ]
        )
    }
}
