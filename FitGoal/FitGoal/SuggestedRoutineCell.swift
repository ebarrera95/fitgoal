//
//  RoutineCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SuggestedRoutineCell: UICollectionViewCell {
    
    static var indentifier: String = "Suggestions"
    
    var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var subtitle: UILabel = {
           let title = UILabel(frame: .zero)
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
    }()
    
    var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "Home_outside")
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var roundedButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .green
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backgroundImage)
        addBackgroundImageSubview()
        
        layoutBackgroundImageView()
        layoutBackgroundImageSubviews()
    }
    
    private func layoutTitelLabel() {
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 2/3 * backgroundImage.bounds.height),
            self.title.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutSubtitleLabel() {
        NSLayoutConstraint.activate([
            self.subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            self.subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor)
        ])
    }
    private func layoutBackgroundImageView() {
        backgroundImage.bounds.size = CGSize(width: contentView.bounds.size.width - 30, height: contentView.bounds.height)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            self.backgroundImage.heightAnchor.constraint(equalToConstant: backgroundImage.bounds.height),
            self.backgroundImage.widthAnchor.constraint(equalToConstant: backgroundImage.bounds.size.width),
            self.backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutButton() {
        NSLayoutConstraint.activate([
            self.roundedButton.topAnchor.constraint(equalTo: title.topAnchor),
            self.roundedButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16),
            self.roundedButton.widthAnchor.constraint(equalToConstant: 48),
            self.roundedButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func addBackgroundImageSubview() {
        backgroundImage.addSubview(title)
        backgroundImage.addSubview(subtitle)
        backgroundImage.addSubview(roundedButton)
    }
    private func layoutBackgroundImageSubviews() {
        layoutTitelLabel()
        layoutSubtitleLabel()
        layoutButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
