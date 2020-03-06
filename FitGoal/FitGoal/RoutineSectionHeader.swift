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
                headerLabel.attributedText = configureSectionHeader(with: string)
            } else {
                headerLabel.attributedText = nil
            }
        }
    }
    
    var link: UILabel = {
        let linkLabel = UILabel(frame: .zero)
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSAttributedString(string: "See All", attributes: [
            .font: UIFont(name: "Roboto-Regular", size: 14)!,
            .foregroundColor: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
            .kern: 0.1
        ])
        linkLabel.attributedText = attributedText
        
        linkLabel.isHidden = true
        return linkLabel
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  16),
            backgroundView.widthAnchor.constraint(equalToConstant: self.bounds.size.width - 32),
            backgroundView.heightAnchor.constraint(equalToConstant: self.bounds.size.height)
        ])
    }
    
    private func layoutHeaderLabel() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor)
        ])
    }
    
    private func layoutLink() {
        NSLayoutConstraint.activate([
            link.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            link.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
    }
    
    func configureSectionHeader(with string: String?) -> NSAttributedString? {
        if let header = string {
            let capString = header.localizedUppercase
            let atributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "Oswald-Medium", size: 16)!,
                .foregroundColor: UIColor(red: 0.38, green: 0.39, blue: 0.39, alpha: 1),
                .kern: 0.17
            ]
            let sectionHeader = NSAttributedString(string: capString, attributes: atributes)
            return sectionHeader
        } else {
            return nil
        }
    }
}
