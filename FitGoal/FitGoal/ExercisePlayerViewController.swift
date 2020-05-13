//
//  ExercisePlayerViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExercisePlayerViewController: UIViewController {
    
    private let exercise: Exercise
    
    private var imageLoadingState: ImageLoadingState = .inProgress {
        didSet {
            switch imageLoadingState {
            case .inProgress:
                aboveImageGradientView.isHidden = true
                playButton.isHidden = true
                placeholder.startAnimating()
            case .finished(let image):
                aboveImageGradientView.isHidden = false
                playButton.isHidden = false
                placeholder.stopAnimating()
                exerciseImage.image = image
            case .failed(let error):
                print("Unable to load image with error: \(error)")
            }
        }
    }

    private let exerciseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let aboveImageGradientView: UIView = {
           let gradientView = GradientView(frame: .zero)
           gradientView.layer.cornerRadius = 7
           gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
           return gradientView
    }()
    
    private let belowImageShadowView: UIView = {
        var shadow = UIView()
        shadow.clipsToBounds = false
        shadow.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadow.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowRadius = 10
        return shadow
    }()
    
    private let colourfulImageShadowView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 9
        gradientView.colors = [#colorLiteral(red: 0.18, green: 0.74, blue: 0.89, alpha: 1), #colorLiteral(red: 0.51, green: 0.09, blue: 0.86, alpha: 1)]
        gradientView.startPoint = CGPoint(x: 0, y: 0.70)
        gradientView.endPoint = CGPoint(x: 1, y: 0.74)
        gradientView.alpha = 0.15
        return gradientView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "PlayButton"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 72, height: 72)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle("stop".uppercased().formattedText(font: "Roboto-Light", size: 15, color: .white, kern: 0.18), for: .normal)
        return button
    }()
    
    init(exercise: Exercise) {
        self.exercise = exercise
        super.init(nibName: nil, bundle: nil)
        fetchImage(with: exercise.url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        belowImageShadowView.addSubview(exerciseImage)
        view.addSubview(BackgroundGradientView(frame: view.bounds))
        let views = [
            colourfulImageShadowView,
            belowImageShadowView,
            aboveImageGradientView,
            playButton,
            placeholder,
            stopButton
        ]
        view.addMultipleSubviews(views)
        setBelowImageShadowViewConstraints()
        setColourfulImageShadowViewConstraints()
        setStopButtonConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        exerciseImage.frame = belowImageShadowView.bounds
        aboveImageGradientView.frame = belowImageShadowView.frame
        playButton.center = belowImageShadowView.center
    }
    
    private func fetchImage(with imageURL: URL) {
        imageURL.fetchImage { result in
            DispatchQueue.main.async {
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
    
    private func setColourfulImageShadowViewConstraints() {
       colourfulImageShadowView.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           colourfulImageShadowView.bottomAnchor.constraint(equalTo: belowImageShadowView.bottomAnchor, constant: 16),
           colourfulImageShadowView.leadingAnchor.constraint(equalTo: belowImageShadowView.leadingAnchor, constant: 16),
           colourfulImageShadowView.trailingAnchor.constraint(equalTo: belowImageShadowView.trailingAnchor, constant: -16),
           colourfulImageShadowView.heightAnchor.constraint(equalToConstant: 30)
       ])
    }
    
    private func setBelowImageShadowViewConstraints() {
        belowImageShadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            belowImageShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            belowImageShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            belowImageShadowView.heightAnchor.constraint(equalToConstant: 228),
            belowImageShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setStopButtonConstraints() {
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54)
        ])
    }
}
