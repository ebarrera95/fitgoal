//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserGenderViewController: UIViewController {
    
    private let genderChooserView = GenderView()
    
    private var questionPrefix: UILabel = {
        let label = UILabel()
        label.attributedText = "What is".formattedText(font: "Roboto-Light", size: 19, color: .white, kern: 0.23)
        return label
    }()
    private var questionSuffix: UILabel = {
        let label = UILabel()
        label.attributedText = "YOUR GENDER?".formattedText(font: "Oswald-Medium", size: 50, color: .white, kern: 0.59)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        
        let views = [
            genderChooserView,
            questionPrefix,
            questionSuffix
        ]
        view.addMultipleSubviews(views)
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        genderChooserView.frame = CGRect(x: 0, y: 0, width: 320, height: 152)
        genderChooserView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
    }
    
    private func setConstraints() {
        setQuestionPrefixLabelConstraints()
        setQuestionSuffixLabelConstraints()
    }
    
    private func setQuestionPrefixLabelConstraints() {
        questionPrefix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionPrefix.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            questionPrefix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionSuffix.topAnchor.constraint(equalTo: questionPrefix.bottomAnchor, constant: 8),
            questionSuffix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }

}
//TODO: This enum will be replaced after next PR
enum SelectorType {
    case fitnessLevel
    case fitnessGoal
    case gender
}
