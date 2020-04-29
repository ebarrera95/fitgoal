//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SelectorViewController: UIViewController {
    
    private var selectorType: SelectorType
    
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
        var viewHeight = Int()
        switch selectorType {
        case .age, .height, .weight:
            viewHeight = 152
        case .fitnessGoal, .fitnessLevel, .gender:
            viewHeight = 320
        }
        selectorView.frame = CGRect(x: 0, y: 0, width: 320, height: viewHeight)
        selectorView.center = CGPoint(x: view.center.x, y: view.center.y + 30)
    }
    
    private func setConstraints() {
        setQuestionPrefixLabelConstraints()
        setQuestionSuffixLabelConstraints()
    }
    
    private func setQuestionPrefixLabelConstraints() {
        questionPrefix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionPrefix.bottomAnchor.constraint(equalTo: self.questionSuffix.topAnchor),
            questionPrefix.leadingAnchor.constraint(equalTo: self.selectorView.leadingAnchor)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionSuffix.bottomAnchor.constraint(equalTo: selectorView.topAnchor, constant: -16),
            questionSuffix.leadingAnchor.constraint(equalTo: selectorView.leadingAnchor)
        ])
    }
}

enum SelectorType {
    case fitnessLevel
    case fitnessGoal
    case gender
    case age
    case weight
    case height
    
    var prefix: String {
        switch self {
        case .fitnessGoal:
            return "What is"
        case .fitnessLevel:
            return "What is your current fitness"
        case .gender, .age, .height, .weight:
            return "What is"
        }
    }
    
    var suffix: String {
        var suffix = String()
        switch self {
        case .fitnessGoal:
            suffix = "your goal"
        case .gender:
            suffix = "your gender"
        case .fitnessLevel:
            suffix = "level"
        case .age:
            suffix = "your age"
        case .weight:
            suffix = "your weight"
        case .height:
            suffix = "your height"
        }
        return suffix
    }
    
    var view: UIView {
        switch self {
        case .fitnessGoal:
            return FitnessLevelChooserView()
        case .fitnessLevel:
            return FitnessLevelChooserView()
        case .gender:
            return GenderView()
        case .age:
            return QuantitativeUserInfoView()
        case .weight:
            fatalError()
        case .height:
            fatalError()
        }
    }
}
