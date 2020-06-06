//
//  CountDownViewController.swift
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
        let background = ExercisePlayerBackgroundView(frame: view.bounds)
        view.addSubview(background)
        let views = [countdownLabel, countdownMessageLabel, stopButton]
        view.addMultipleSubviews(views)
        setConstraints()
        runCountdown()
        stopButton.addTarget(self, action: #selector(handleCountdownStop), for: .touchUpInside)
    }
    
    private func runCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.countdownSeconds > 0 {
                self.setCountdownTime(time: String(self.countdownSeconds))
                self.setCountdownMessage(message: self.countdownMessages[self.countdownSeconds - 1])
                self.countdownSeconds -= 1
            } else {
                timer.invalidate()
            }
        })
    }

    private func setCountdownMessage(message: String) {
        countdownMessageLabel.attributedText = message.formattedText(font: "Roboto-Regular", size: 35, color: .white, kern: -0.13)
    }
    
    private func setCountdownTime(time: String) {
        countdownLabel.attributedText = time.formattedText(font: "Oswald-Medium", size: 181, color: .white, kern: 2.18)
    }
    
    @objc private func handleCountdownStop() {
        self.dismiss(animated: true) {
            self.timer.invalidate()
        }
    }
    
    private func setConstraints() {
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
