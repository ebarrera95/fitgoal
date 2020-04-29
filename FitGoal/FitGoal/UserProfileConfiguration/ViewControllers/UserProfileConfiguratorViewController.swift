//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserProfileConfiguratorViewController: UIViewController {
    
    private var configuratorType: UserProfileConfiguratorType
    
    private var selectorView: UIView
    private var questionPrefix = UILabel()
    private var questionSuffix = UILabel()
    
    init(configuratorType: UserProfileConfiguratorType) {
        self.configuratorType = configuratorType
        selectorView = configuratorType.view
        super.init(nibName: nil, bundle: nil)
        configureQuestions(prefix: configuratorType.prefix, suffix: configuratorType.suffix)
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
        
        let dismissKeyBoardTap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(dismissKeyBoardTap)
    }
    
    @objc private func dismissKeyboard() {
        switch configuratorType {
        case .age, .height, .weight:
            guard let textField = selectorView as? UITextField else {
                fatalError()
            }
            textField.resignFirstResponder()
        case .fitnessGoal, .fitnessLevel, .gender:
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSelectorView()
    }
    
    private func layoutSelectorView() {
        let viewHeight = setHeight(forView: selectorView)
        selectorView.frame = CGRect(x: 0, y: 0, width: 320, height: viewHeight)
        setSelectorViewCenter()
    }
    
    private func setSelectorViewCenter() {
        switch configuratorType {
        case .age, .height, .weight:
           selectorView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
        case .fitnessGoal, .fitnessLevel, .gender:
            selectorView.center = CGPoint(x: view.center.x, y: view.center.y + 30)
        }
    }
    
    private func setHeight(forView view: UIView) -> CGFloat {
        let viewHeight: CGFloat
        switch configuratorType {
        case .age, .height, .weight:
            viewHeight = 152
        case .fitnessGoal, .fitnessLevel, .gender:
            viewHeight = 320
        }
        return viewHeight
    }
    
    //MARK: -Constraints
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

enum UserProfileConfiguratorType {
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
        return suffix.uppercased()
    }
    
    var view: UIView {
        switch self {
        case .fitnessGoal:
            return FitnessLevelChooserView()
        case .fitnessLevel:
            return FitnessLevelChooserView()
        case .gender:
            return GenderView()
        case .age, .height, .weight:
            return getTextField()
        }
    }
    
    private func getTextField() -> UITextField {
        let texField = UITextField()
        texField.backgroundColor = .white
        texField.layer.cornerRadius = 7
        texField.layer.shadowOffset = CGSize(width: 0, height: 6)
        texField.layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        texField.layer.shadowOpacity = 1
        texField.layer.shadowRadius = 10
        texField.layer.cornerRadius = 7
        texField.keyboardType = .asciiCapableNumberPad
        texField.textColor = #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1)
        texField.font = UIFont(name: "Oswald-Medium", size: 50)
        texField.textAlignment = .center
        return texField
    }
}
