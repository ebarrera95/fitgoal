//
//  ExerciseCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    
    private var exerciseImageConfigurator: ExerciseImageConfigurator?
    
    var exercise: Exercise? {
        didSet {
             imageURL = exercise?.url
            //Title
            guard let title = exercise?.name else { return }
            let cellTitle = title.uppercased().formattedText(
                font: "Roboto-Bold",
                size: 14,
                color: .white,
                kern: 0.14
            )
            self.title.attributedText = cellTitle
        }
    }
    
    static let identifier = "Cell Exercise"
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    private var imageURL: URL? {
        didSet {
            guard let imageURL = self.imageURL else { return }
            let imageFetcher = ImageFetcher.init(url: imageURL)
            exerciseImageConfigurator = ExerciseImageConfigurator(imageFetcher: imageFetcher, exerciseImageView: backgroundImage, imageGradient: gradientView, placeholder: placeholder)
        }
    }

    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private var title = UILabel()
    
    private var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()
    
    private var dayIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private var dayIndicatorLabel: UILabel = {
        let title = UILabel()
        title.attributedText = "Wednesday".formattedText (
            font: "Roboto-Regular",
            size: 12,
            color: .white,
            kern: 0)
        return title
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        
        let views = [backgroundImage, placeholder, gradientView,  title, dayIndicator]
        addSubviewsToContentView(views: views)
        
        dayIndicator.addSubview(dayIndicatorLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = contentView.bounds
        gradientView.frame = contentView.bounds
        placeholder.center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
    }
    
    private func addSubviewsToContentView(views: [UIView]) {
        views.forEach { view in
            self.contentView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        setIndicatorLabelConstraints()
        setDayIndicatorConstraints()
        setTitleLabelConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        imageURL = nil
        gradientView.isHidden = true
        exerciseImageConfigurator?.cancelConfiguration()
    }
    
    //MARK: - Constraints
    
    private func setTitleLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: dayIndicator.topAnchor, constant: -4),
            title.leadingAnchor.constraint(equalTo: dayIndicatorLabel.leadingAnchor)
        ])
    }
    
    private func setDayIndicatorConstraints() {
        dayIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            dayIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dayIndicator.widthAnchor.constraint(equalToConstant: 80),
            dayIndicator.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setIndicatorLabelConstraints() {
           dayIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               dayIndicatorLabel.centerYAnchor.constraint(equalTo: dayIndicator.centerYAnchor),
               dayIndicatorLabel.centerXAnchor.constraint(equalTo: dayIndicator.centerXAnchor)
           ])
    }
}
