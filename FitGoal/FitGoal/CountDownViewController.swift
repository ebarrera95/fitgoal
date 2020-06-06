//
//  CountDownViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 12/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol CountDownViewControllerDelegate: AnyObject {
    func countDownViewController(_ viewController: CountDownViewController, didDismiss: Bool)
}

class CountDownViewController: UIViewController {
    
    weak var delegate: CountDownViewControllerDelegate?
    
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
        let background = ExercisePlayerBackgroundView(frame: view.bounds)
        view.addSubview(background)
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
            self.dismiss(animated: true) {
                self.delegate?.countDownViewController(self, didDismiss: true)
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
