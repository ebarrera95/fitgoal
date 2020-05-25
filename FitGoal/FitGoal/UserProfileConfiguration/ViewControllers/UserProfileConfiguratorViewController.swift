//
//  UserGenderViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserProfileConfiguratorViewController: UIViewController {
    
    private let userInfoEntryView: UIView
    private let questionPrefix = UILabel()
    private let questionSuffix = UILabel()
    
    private let userInfoEntryViewDelegate: UserInfoEntryViewDelegate
    
    init(userInfoEntryView: UIView, questionPrefix: String, questionSuffix: String, userProfileType: UserProfileType) {
        self.userInfoEntryView = userInfoEntryView
        self.userInfoEntryViewDelegate = UserInfoEntryViewDelegate(userInfoEntryView: userInfoEntryView, userProfileType: userProfileType)
        
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
            userInfoEntryView,
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
        guard let textField = userInfoEntryView as? UITextField else {
            return
        }
        textField.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSelectorView()
    }
    
    private func layoutSelectorView() {
        if userInfoEntryView is UITextField {
            userInfoEntryView.frame = CGRect(x: 0, y: 0, width: 340, height: 152)
            userInfoEntryView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 30)
        } else {
            userInfoEntryView.frame = CGRect(x: 0, y: 0, width: 340, height: 340)
            userInfoEntryView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 30)
        }
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
            questionPrefix.leadingAnchor.constraint(equalTo: self.userInfoEntryView.leadingAnchor)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffix.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionSuffix.bottomAnchor.constraint(equalTo: userInfoEntryView.topAnchor, constant: -16),
            questionSuffix.leadingAnchor.constraint(equalTo: userInfoEntryView.leadingAnchor)
        ])
    }
}

enum UserProfileType {
    case gender
    case fitnessLevel
    case fitnessGoal
    case age
    case height
    case weight
}
