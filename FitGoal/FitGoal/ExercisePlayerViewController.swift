//
//  ExercisePlayerViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 12/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExercisePlayerViewController: UIPageViewController {
    //MARK: -This properties are connected to the VC second stage
    
    private let exercise: Exercise
    private let routine: [Exercise]
    
    private let countdownLabel = UILabel()
    private let countdownMessageLabel = UILabel()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle("stop".uppercased().formattedText(font: "Roboto-Light", size: 15, color: .white, kern: 0.18), for: .normal)
        return button
    }()
    
    private var timer = Timer()
    private var countdownSeconds = 3
    private let countdownMessages = ["Let's start!", "You can do it!", "Ready!"]
    
    private var exerciseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var imageGradient: UIView = {
           let gradientView = GradientView(frame: .zero)
           gradientView.layer.cornerRadius = 7
           gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
           return gradientView
    }()
    
    private var grayShadow: UIView = {
        var shadow = UIView()
        shadow.backgroundColor = .red
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
    
    private var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "PlayButton"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 72, height: 72)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    init(exercise: Exercise, routine: [Exercise]) {
        self.exercise = exercise
        self.routine = routine
        super.init(transitionStyle: .scroll,
            navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let views = [countdownLabel, countdownMessageLabel, stopButton]
        view.addSubview(ExerciseBackgroundView(frame: self.view.frame))
        view.addMultipleSubviews(views)
        setConstraintsForCountDownRelatedViews()
        runCountdown()
        stopButton.addTarget(self, action: #selector(handleCountdownStop), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        exerciseImage.frame = grayShadow.bounds
        imageGradient.frame = grayShadow.frame
        playButton.center = grayShadow.center
    }
    
    @objc private func fireTimer() {
        if self.countdownSeconds > 0 {
            self.setCountdownTime(time: String(self.countdownSeconds))
            self.setCountdownMessage(message: self.countdownMessages[self.countdownSeconds - 1])
            self.countdownSeconds -= 1
        } else {
            self.timer.invalidate()
            removeCountdownViews()
            insertExerciseViews()
        }
    }
    
    @objc private func handleCountdownStop() {
        self.dismiss(animated: true) {
            self.timer.invalidate()
        }
    }
    
    private func runCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    private func removeCountdownViews() {
        countdownLabel.removeFromSuperview()
        countdownMessageLabel.removeFromSuperview()
    }
    
    private func insertExerciseViews() {
        grayShadow.addSubview(exerciseImage)
        let views = [
            grayShadow,
            imageGradient,
            shadowWithGradient,
            playButton,
            placeholder
        ]
        view.addMultipleSubviews(views)
        setGrayShadowConstraints()
        setShadowWithGradientConstraints()
        view.layoutIfNeeded()
    }

    private func setCountdownMessage(message: String) {
        countdownMessageLabel.attributedText = message.formattedText(font: "Roboto-Regular", size: 35, color: .white, kern: -0.13)
    }
    
    private func setCountdownTime(time: String) {
        countdownLabel.attributedText = time.formattedText(font: "Oswald-Medium", size: 181, color: .white, kern: 2.18)
    }
    
    private func setConstraintsForCountDownRelatedViews() {
        setStopButtonConstraints()
        setCountDownLabelConstraints()
        setCountDownMessageLabelConstraint()
    }
    
    private func setStopButtonConstraints() {
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54)
        ])
    }
    
    private func setCountDownLabelConstraints() {
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 16)
        ])
    }
    
    private func setCountDownMessageLabelConstraint() {
        countdownMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countdownMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownMessageLabel.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func setShadowWithGradientConstraints() {
       shadowWithGradient.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           shadowWithGradient.bottomAnchor.constraint(equalTo: grayShadow.bottomAnchor, constant: 16),
           shadowWithGradient.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor, constant: 16),
           shadowWithGradient.trailingAnchor.constraint(equalTo: grayShadow.trailingAnchor, constant: -16),
           shadowWithGradient.heightAnchor.constraint(equalToConstant: 30)
       ])
    }
    
    private func setGrayShadowConstraints() {
        grayShadow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grayShadow.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            grayShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            grayShadow.heightAnchor.constraint(equalToConstant: 228),
            grayShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

//TODO: See if this makes sense, it could be that a better way exist to manage repeating backgrounds that creating a new type for it.
class ExerciseBackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addMultipleSubviews(generateBackgroundView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateGradientView(cornerRadius: CGFloat, maskedCorners: CACornerMask, colors: [UIColor], rotationAngle: CGFloat, translationInX: CGFloat, translationInY: CGFloat, alpha: CGFloat) -> UIView {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 600, height: 812))
        gradientView.layer.cornerRadius =  cornerRadius
        gradientView.layer.maskedCorners = maskedCorners
        gradientView.colors = colors
        let rotation = CGAffineTransform(rotationAngle: rotationAngle / 180 * CGFloat.pi)
        gradientView.alpha = alpha
        gradientView.transform = rotation.translatedBy(x: translationInX, y: translationInY)
        return gradientView
    }
    
    private func generateBackgroundView() -> [UIView]  {
        let gradientBackgroundView: UIView = {
            let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
            gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
            return gradientView
        }()
        
        let topLeftGradientView = generateGradientView(
            cornerRadius: 175,
            maskedCorners: .layerMinXMaxYCorner,
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            rotationAngle: -30,
            translationInX: 60,
            translationInY: -730,
            alpha: 0.1
        )
        
        let topRightGradientView = generateGradientView(
            cornerRadius: 175,
            maskedCorners: .layerMaxXMaxYCorner,
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            rotationAngle: 35,
            translationInX: -350,
            translationInY: -630,
            alpha: 0.25
        )
        
        let bottomRightGradientView = generateGradientView(
            cornerRadius: 130,
            maskedCorners: .layerMinXMinYCorner,
            colors: [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)],
            rotationAngle: 60,
            translationInX: 620,
            translationInY: 450,
            alpha: 0.70
        )
        
        return [gradientBackgroundView, topLeftGradientView, topRightGradientView, bottomRightGradientView]
    }
}
