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
    
    private var iconListViewDelegate: IconListDelegate?
    private var userInfoTextFieldDelegate: UserInfoTextFieldDelegate?
    
    private init(userInfoEntryView: UIView, questionPrefix: String, questionSuffix: String) {
        self.userInfoEntryView = userInfoEntryView
        super.init(nibName: nil, bundle: nil)
        configureQuestions(prefix: questionPrefix, suffix: questionSuffix)
    }
    
    convenience init(iconListView: IconListView, questionPrefix: String, questionSuffix: String, qualitativeUserInfo: QualitativeUserInfo) {
        
        self.init(userInfoEntryView: iconListView, questionPrefix: questionPrefix, questionSuffix: questionSuffix)
        
        guard let iconListView = userInfoEntryView as? IconListView else { return }
        self.iconListViewDelegate = IconListDelegate(listView: iconListView, qualitativeUserInfo: qualitativeUserInfo)
        iconListView.delegate = self.iconListViewDelegate
    }
    
    convenience init(textField: UITextField, questionPrefix: String, questionSuffix: String, quantitativeInfo: QuantitativeUserInfo) {
        
        self.init(userInfoEntryView: textField, questionPrefix: questionPrefix, questionSuffix: questionSuffix)
        
        guard let textField = userInfoEntryView as? UITextField else { return }
        self.userInfoTextFieldDelegate = UserInfoTextFieldDelegate(textField: textField, quantitativeUserInfo: quantitativeInfo)
        textField.delegate = userInfoTextFieldDelegate
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
        userInfoEntryView.resignFirstResponder()
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
