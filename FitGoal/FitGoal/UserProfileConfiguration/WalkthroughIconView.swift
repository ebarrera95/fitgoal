//
//  IconBuilderView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class WalkthroughIconView: UIView {
    
    var icon: WalkthroughIcon
    
    private var title = UILabel()
    
    private let indicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let background = UIView()
        background.layer.cornerRadius = 7
        background.layer.borderWidth = 2
        background.layer.borderColor = #colorLiteral(red: 0.2431372549, green: 0.7803921569, blue: 0.9019607843, alpha: 1).cgColor
        background.backgroundColor = #colorLiteral(red: 0.2, green: 0.8823529412, blue: 1, alpha: 0.09823393486)
        return background
    }()
    
    var isSelected = false {
        didSet {
            icon.selected = isSelected
            backgroundView.isHidden = !isSelected
            configureIcon(forState: icon.selected, withName: icon.name)
        }
    }
    
    init(icon: WalkthroughIcon) {
        self.icon = icon
        super.init(frame: .zero)
        configureIcon(forState: icon.selected, withName: icon.name)
        backgroundView.isHidden = true
        
        backgroundColor = .white
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        
        let views = [
            backgroundView,
            indicator,
            title,
            mainImage
        ]
        self.addMultipleSubviews(views)
        setConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = self.bounds
    }
    
    private func configureIcon(forState selectedState: Bool, withName name: String) {
        configureSelectionIndicator(for: selectedState)
        title.attributedText = configureTitle(for: selectedState, with: name)
        mainImage.image = icon.image
    }
    
    private func configureSelectionIndicator(for selectedState: Bool) {
        if selectedState {
            indicator.image = UIImage(imageLiteralResourceName: "selectedIndicator")
        } else {
            indicator.image = UIImage(imageLiteralResourceName: "unselectedIndicator")
        }
    }
    
    private func configureTitle(for state: Bool, with iconName: String) -> NSAttributedString {
        var attributedString = NSAttributedString()
        
        if icon.selected {
            attributedString = iconName.formattedText(
                font: "Roboto-Bold",
                size: 15,
                color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
                kern: 0.3
            )
        } else {
            attributedString = iconName.formattedText(
                font: "Roboto-Light",
                size: 15,
                color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
                kern: 0.3
            )
        }
        return attributedString
    }
    
    //MARK: -Constraints
    
    private func setConstraints() {
        setIndicatorConstraints()
        setLabelConstraints()
        setMainImageConstraints()
    }
    
    private func setIndicatorConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 27),
            indicator.heightAnchor.constraint(equalToConstant: 27),
            indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            indicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
        ])
    }
    
    private func setLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    private func setMainImageConstraints() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImage.widthAnchor.constraint(equalToConstant: 45),
            mainImage.heightAnchor.constraint(equalToConstant: 80),
            mainImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
