//
//  ExercisePreviewCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExercisePreviewCell: UICollectionViewCell {
    
    static var identifier = "Exercise Preview"
    
    private var imageLoadingState: ImageLoadingState = .inProgress {
        didSet {
            switch imageLoadingState {
            case .inProgress:
                imageGradient.isHidden = true
                playButton.isHidden = true
                placeholder.startAnimating()
            case .finished(let image):
                imageGradient.isHidden = false
                playButton.isHidden = false
                placeholder.stopAnimating()
                exerciseImage.image = image
            case .failed(let error):
                print("Unable to load image with error: \(error)")
            }
        }
    }
    
    var exercise: Exercise? {
        didSet {
            imageURL = exercise?.url
            guard let title = exercise?.name else { return }
            
            cellTitle.attributedText = title.uppercased().formattedText(
                font: "Oswald-Medium",
                size: 34,
                color: .white,
                kern: -0.14
            )
        }
    }
    
    private var currentImageDownloadTask: URLSessionTask?
    
    private var imageURL: URL? {
        didSet {
            guard let imageURL = imageURL else {
                return
            }
            currentImageDownloadTask = imageURL.fetchImage { result in
                DispatchQueue.main.async {
                    guard self.imageURL == imageURL else { return }
                    switch result {
                    case .failure(let error):
                        self.imageLoadingState = .failed(error)
                    case .success(let image):
                        imageCache[imageURL] = image
                        self.imageLoadingState = .finished(image)
                    }
                }
            }
        }
    }
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 15, y: -650)
        return gradientView
    }()
    
    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private var imageGradient: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()

    private var exerciseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var cellTitle = UILabel()
    
    private var grayShadow: UIView = {
        var shadow = UIView()
        shadow.clipsToBounds = false
        shadow.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadow.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowRadius = 10
        return shadow
    }()
    
    private var shadowWithGradient: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 9
        gradientView.colors = [#colorLiteral(red: 0.18, green: 0.74, blue: 0.89, alpha: 1), #colorLiteral(red: 0.51, green: 0.09, blue: 0.86, alpha: 1)]
        gradientView.startPoint = CGPoint(x: 0, y: 0.70)
        gradientView.endPoint = CGPoint(x: 1, y: 0.74)
        gradientView.alpha = 0.15
        return gradientView
    }()
    
    private var playButton: UIImageView = {
        let view = UIImageView(image: UIImage(imageLiteralResourceName: "PlayButton"))
        view.contentMode = .scaleAspectFit
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [gradientBackgroundView, shadowWithGradient, grayShadow, playButton, placeholder, cellTitle]
        addSubviewsToContentView(views: views)
        
        grayShadow.addSubview(exerciseImage)
        grayShadow.addSubview(imageGradient)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholder.center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
        imageGradient.frame = grayShadow.bounds
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setGrayShadowConstraints()
        setShadowWithGradientConstraints()
        setPlayButtonConstraints()
        setBackgroundImageConstraints()
        setImageGradientConstraints()
    }
    
    private func addSubviewsToContentView(views: [UIView]) {
        views.forEach { view in
            self.contentView.addSubview(view)
        }
    }
    
    //MARK: - Constraints
    
    private func setTitleLabelConstraints() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellTitle.bottomAnchor.constraint(equalTo: grayShadow.topAnchor, constant: -16),
            cellTitle.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor)
        ])
    }
    
    private func setGrayShadowConstraints() {
        grayShadow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grayShadow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            grayShadow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            grayShadow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            grayShadow.heightAnchor.constraint(equalToConstant: 228)
        ])
    }
    
    private func setBackgroundImageConstraints() {
        exerciseImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exerciseImage.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor),
            exerciseImage.trailingAnchor.constraint(equalTo:grayShadow.trailingAnchor),
            exerciseImage.heightAnchor.constraint(equalTo: grayShadow.heightAnchor),
            exerciseImage.widthAnchor.constraint(equalTo: grayShadow.widthAnchor)
        ])
    }
    
    private func setImageGradientConstraints() {
        imageGradient.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageGradient.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor),
            imageGradient.trailingAnchor.constraint(equalTo:grayShadow.trailingAnchor),
            imageGradient.heightAnchor.constraint(equalTo: grayShadow.heightAnchor),
            imageGradient.widthAnchor.constraint(equalTo: grayShadow.widthAnchor)
        ])
    }
    
    private func setShadowWithGradientConstraints() {
        shadowWithGradient.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowWithGradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shadowWithGradient.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor, constant: 16),
            shadowWithGradient.trailingAnchor.constraint(equalTo: grayShadow.trailingAnchor, constant: -16),
            shadowWithGradient.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setPlayButtonConstraints() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: grayShadow.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: grayShadow.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 72),
            playButton.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
}
