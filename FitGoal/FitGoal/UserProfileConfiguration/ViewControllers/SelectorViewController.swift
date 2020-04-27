//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SelectorViewController: UIViewController {
    
    private let selectorType: SelectorType
    
    private var selectorView: UIView
    
    private var questionPrefix = UILabel()
    private var questionSuffix = UILabel()
    
    init(selectorType: SelectorType) {
        self.selectorType = selectorType
        selectorView = selectorType.view
        super.init(nibName: nil, bundle: nil)
        configureQuestions(prefix: selectorType.prefix, suffix: selectorType.suffix)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureQuestions(prefix: String, suffix: String) {
        questionPrefix.attributedText = prefix.formattedText(font: "Roboto-Light", size: 19, color: .white, kern: 0.23)
        questionSuffix.attributedText = suffix.formattedText(font: "Oswald-Medium", size: 50, color: .white, kern: 0.59)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        
        let views = [
            selectorView,
            questionPrefix,
            questionSuffix
        ]
        view.addMultipleSubviews(views)
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectorView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        selectorView.center = CGPoint(x: view.center.x, y: view.center.y + 50)
    }
    
    private func setConstraints() {
        setQuestionPrefixLabelConstraints()
        setQuestionSuffixLabelConstraints()
    }
    
    private func setQuestionPrefixLabelConstraints() {
        questionPrefix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionPrefix.bottomAnchor.constraint(equalTo: self.questionSuffix.topAnchor, constant: -2),
            questionPrefix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionSuffix.bottomAnchor.constraint(equalTo: selectorView.topAnchor, constant: -16),
            questionSuffix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }

}
//TODO: This enum will be replaced after next PR
enum SelectorType {
    case fitnessLevel
    case fitnessGoal
    case gender
    
    var prefix: String {
        switch self {
        case .fitnessGoal:
            return "What is your fitness"
        case .fitnessLevel:
            return "What is your fitness"
        case .gender:
            return "What is your"
        }
    }
    
    var suffix: String {
        switch self {
        case .fitnessGoal:
            return "goal".uppercased()
        case .gender:
            return "gender".uppercased()
        case .fitnessLevel:
            return "level".uppercased()
        }
    }
    
    var view: UIView {
        switch self {
        case .fitnessGoal:
            return BodyLevelView()
        case .fitnessLevel:
            return BodyLevelView()
        case .gender:
            return GenderView()
        }
    }
}
