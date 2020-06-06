//
//  RoutineCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol SuggestedRoutineCellDelegate: AnyObject {
    func userDidSelectRoutine(_ routine: Routine)
}

class SuggestedRoutineCell: UICollectionViewCell {    
    
    static let identifier: String = "Suggestions"
    
    weak var delegate: SuggestedRoutineCellDelegate?
    
    private var exerciseImageConfigurator: ExerciseImageConfigurator?
    
    var routine: Routine? {
        didSet {
            imageURL = routine?.url
            
            //configure title
            guard let title = routine?.name else { return }
            let cellTitle = title.uppercased().formattedText(
                font: "Roboto-Bold",
                size: 12,
                color: .white,
                kern: 0.14
            )
            
            self.title.attributedText = cellTitle
            
            //configure subtitle
            guard let numberOfExercises = routine?.exercises.count else { return }
            let subtitle = "\(numberOfExercises) New".formattedText(
                font: "Roboto-Regular",
                size: 9,
                color: .white,
                kern: 0.11
            )

            self.subtitle.attributedText = subtitle
        }
    }

    private var imageURL: URL? {
        didSet {
            guard let imageURL = self.imageURL else { return }
            let imageFetcher = ImageFetcher.init(url: imageURL)
            exerciseImageConfigurator = ExerciseImageConfigurator(imageFetcher: imageFetcher, exerciseImageView: backgroundImage, imageGradient: gradientView, placeholder: placeholder)
        }
    }

    private var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()
    
    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private var title = UILabel()
    
    private var subtitle = UILabel()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(imageLiteralResourceName: "icons - System - Add"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroundImage)
        
        let subviews = [gradientView, placeholder, title, subtitle, addButton]
        addSubviewsToContentView(views: subviews)
        
        addButton.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        
        layoutBackgroundImageSubviews()
    }
    
    @objc private func handleTouch() {
        guard let routine = routine else { return }
        delegate?.userDidSelectRoutine(routine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        imageURL = nil
        gradientView.isHidden = true
        exerciseImageConfigurator?.cancelConfiguration()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = contentView.bounds
        gradientView.frame = contentView.bounds
        placeholder.center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
    }
    
    //MARK: - Set Constrains
    private func setTitleLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -4),
            title.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func setSubtitleLabelConstraints() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -12),
            subtitle.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func setAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -8),
            addButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 25),
            addButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func layoutBackgroundImageSubviews() {
        setSubtitleLabelConstraints()
        setTitleLabelConstraints()
        setAddButtonConstraints()
    }
    
    private func addSubviewsToContentView(views: [UIView]) {
        views.forEach { view in
            self.contentView.addSubview(view)
        }
    }
}
