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
        guard let textField = selectorView as? UITextField else {
            return
        }
        textField.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSelectorView()
    }
    
    private func layoutSelectorView() {
        if selectorView is UITextField {
            selectorView.frame = CGRect(x: 0, y: 0, width: 320, height: 152)
            selectorView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 30)
        } else {
            selectorView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
            selectorView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 30)
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
