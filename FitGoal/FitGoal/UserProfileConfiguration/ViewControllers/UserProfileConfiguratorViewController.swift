//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserProfileConfiguratorViewController: UIViewController {
    
    private let selectorView: UIView
    private let questionPrefix = UILabel()
    private let questionSuffix = UILabel()

    init(selectorView: UIView, questionPrefix: String, questionSuffix: String) {
        self.selectorView = selectorView
        super.init(nibName: nil, bundle: nil)
        configureQuestions(prefix: questionPrefix, suffix: questionSuffix)
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
