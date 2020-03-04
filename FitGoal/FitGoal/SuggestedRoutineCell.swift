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
    
    var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.isHidden = true
        return gradientView
    }()
    
    var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.isHidden = true
        return placeholder
    }()
    
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
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var roundedButton: UIButton = {
        let button = UIButton(frame: .zero)
        //button.backgroundColor = .green
        
        button.setImage(UIImage(imageLiteralResourceName: "icons - System - Add"), for: .normal)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Layouts
    private func layoutTitelLabel() {
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 2/3 * backgroundImage.bounds.height),
            self.title.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutSubtitleLabel() {
        NSLayoutConstraint.activate([
            self.subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            self.subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor)
        ])
    }
    private func layoutBackgroundImageView() {
        backgroundImage.bounds.size = CGSize(width: contentView.bounds.size.width - 32, height: contentView.bounds.height)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.backgroundImage.heightAnchor.constraint(equalToConstant: backgroundImage.bounds.height),
            self.backgroundImage.widthAnchor.constraint(equalToConstant: backgroundImage.bounds.size.width),
            self.backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutButton() {
        NSLayoutConstraint.activate([
            self.roundedButton.topAnchor.constraint(equalTo: title.topAnchor),
            self.roundedButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16),
            self.roundedButton.widthAnchor.constraint(equalToConstant: 25),
            self.roundedButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    private func layoutPlaceHolder() {
        NSLayoutConstraint.activate([
            self.placeholder.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            self.placeholder.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor)
        ])
    }
    private func layoutOverlay() {
        NSLayoutConstraint.activate([
            self.gradientView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            self.gradientView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            self.gradientView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor),
            self.gradientView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor)
        ])
    }
    private func layoutBackgroundImageSubviews() {
        layoutOverlay()
        layoutPlaceHolder()
        layoutTitelLabel()
        layoutSubtitleLabel()
        layoutButton()
    }
    
    private func addBackgroundImageSubview() {
        backgroundImage.addSubview(gradientView)
        backgroundImage.addSubview(placeholder)
        backgroundImage.addSubview(title)
        backgroundImage.addSubview(subtitle)
        backgroundImage.addSubview(roundedButton)
    }
    
}
