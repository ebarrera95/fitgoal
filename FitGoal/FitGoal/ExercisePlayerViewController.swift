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
    
    private var exerciseImageConfigurator: ExerciseImageConfigurator?
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let transparentGradientView: GradientView = {
           let gradientView = GradientView(frame: .zero)
           gradientView.layer.cornerRadius = 7
           gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
           return gradientView
    }()
    
    private let grayShadowView: UIView = {
        var shadow = UIView()
        shadow.clipsToBounds = false
        shadow.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadow.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowRadius = 10
        return shadow
    }()
    
    private let gradientShadowView: UIView = {
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
        let imageFetcher = ImageFetcher(url: exercise.url)
        self.exerciseImageConfigurator = ExerciseImageConfigurator(
            imageFetcher: imageFetcher,
            exerciseImageView: exerciseImageView,
            imageGradient: transparentGradientView,
            placeholder: placeholder
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grayShadowView.addSubview(exerciseImageView)
        view.addSubview(ExercisePlayerBackgroundView(frame: view.frame))
        let views = [
            gradientShadowView,
            grayShadowView,
            transparentGradientView,
            playButton,
            placeholder,
            stopButton
        ]
        view.addMultipleSubviews(views)
        setGrayShadowViewConstraints()
        setGradientShadowViewConstraints()
        setStopButtonConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        exerciseImageView.frame = grayShadowView.bounds
        transparentGradientView.frame = grayShadowView.frame
        playButton.center = grayShadowView.center
    }
    
    private func setGradientShadowViewConstraints() {
       gradientShadowView.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           gradientShadowView.bottomAnchor.constraint(equalTo: grayShadowView.bottomAnchor, constant: 16),
           gradientShadowView.leadingAnchor.constraint(equalTo: grayShadowView.leadingAnchor, constant: 16),
           gradientShadowView.trailingAnchor.constraint(equalTo: grayShadowView.trailingAnchor, constant: -16),
           gradientShadowView.heightAnchor.constraint(equalToConstant: 30)
       ])
    }
    
    private func setGrayShadowViewConstraints() {
        grayShadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grayShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            grayShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            grayShadowView.heightAnchor.constraint(equalToConstant: 228),
            grayShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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
