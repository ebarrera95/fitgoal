//
//  ExercisePlayerViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 12/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {
   
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
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(BackgroundGradientView(frame: view.bounds))
        let views = [countdownLabel, countdownMessageLabel, stopButton]
        view.addMultipleSubviews(views)
        setConstraintsForCountDownRelatedViews()
        runCountdown()
        stopButton.addTarget(self, action: #selector(handleCountdownStop), for: .touchUpInside)
    }
    
    @objc private func fireTimer() {
        if self.countdownSeconds > 0 {
            self.setCountdownTime(time: String(self.countdownSeconds))
            self.setCountdownMessage(message: self.countdownMessages[self.countdownSeconds - 1])
            self.countdownSeconds -= 1
        } else {
            let viewController = ExercisePlayerViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true) {
                self.timer.invalidate()
            }
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
        
    }

    private func setCountdownMessage(message: String) {
        countdownMessageLabel.attributedText = message.formattedText(font: "Roboto-Regular", size: 35, color: .white, kern: -0.13)
    }
    
    private func setCountdownTime(time: String) {
        countdownLabel.attributedText = time.formattedText(font: "Oswald-Medium", size: 181, color: .white, kern: 2.18)
    }
    
    //MARK: -Constraints
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
}

class BackgroundGradientView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addMultipleSubviews(generateBackgroundView())
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
