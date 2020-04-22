//
//  IconBuilderView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class IconBuilderView: UIView {
    
    private var title = UILabel()
    private var indicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    convenience init(icon: BodyShape) {
        self.init(frame: .zero)
        mainImage.image = icon.image
        switch icon {
        case .skinny(let state):
            title.attributedText = configureTitle(for: state, with: icon.name)
            configureIndicator(in: state)
        case .normal(let state):
            title.attributedText = configureTitle(for: state, with: icon.name)
            configureIndicator(in: state)
        case .obese(let state):
            title.attributedText = configureTitle(for: state, with: icon.name)
            configureIndicator(in: state)
        case .athletic(let state):
            title.attributedText = configureTitle(for: state, with: icon.name)
            configureIndicator(in: state)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        
        let views = [indicator, title, mainImage]
        self.addMultipleSubviews(views)
        
        setConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureIndicator(in state: IconState){
        //let indicator = UIImageView()
        switch state {
        case .selected:
            indicator.image = UIImage(imageLiteralResourceName: "selectedIndicator")
        case .unselected:
            indicator.image = UIImage(imageLiteralResourceName: "unselectedIndicator")
        }
    }
    
    
    private func configureTitle(for state: IconState, with iconName: String) -> NSAttributedString {
        var attributedString = NSAttributedString()
        switch state {
        case .selected:
            attributedString = iconName.formattedText(
                font: "Roboto-Bold",
                size: 15,
                color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
                kern: 0.3
            )
        case .unselected:
            attributedString = iconName.formattedText(
                font: "Roboto-Light",
                size: 15,
                color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
                kern: 0.3
            )
        }
        return attributedString
    }
    
    //MARK: -Constraints
    
    func setConstraints() {
        setIndicatorConstraints()
        setLabelConstraints()
        setMainImageConstraints()
    }
    
    func setIndicatorConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 27),
            indicator.heightAnchor.constraint(equalToConstant: 27),
            indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            indicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
        ])
    }
    
    func setLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func setMainImageConstraints() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImage.widthAnchor.constraint(equalToConstant: 40),
            mainImage.heightAnchor.constraint(equalToConstant: 80),
            mainImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
