//
//  UserPlanningViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 30/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserPlanningViewController: UIViewController {
    
    private let easyPlan = TrainingLevelView(level: "Easy", monthsTraining: 6, timesAWeek: 2, selectedStateColor: #colorLiteral(red: 0.2431372549, green: 0.7803921569, blue: 0.9019607843, alpha: 1))
    private let mediumPlan = TrainingLevelView(level: "Medium", monthsTraining: 4, timesAWeek: 4, selectedStateColor: #colorLiteral(red: 1, green: 0.6492816915, blue: 0.5106400314, alpha: 1))
    private let intensePlan = TrainingLevelView(level: "Intense", monthsTraining: 2, timesAWeek: 5, selectedStateColor: #colorLiteral(red: 0.9873231897, green: 0.1885731705, blue: 0.05805841231, alpha: 1))
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        let title = "Continue".formattedText(
            font: "Roboto-Bold",
            size: 17,
            color: .white,
            kern: 0
        )
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private let questionPrefixLabel = UILabel()
    private let questionSuffixLabel = UILabel()
    
    init(questionPrefix: String, questionSuffix: String) {
        super.init(nibName: nil, bundle: nil)
        configureQuestions(prefix: questionPrefix, suffix: questionSuffix)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainingPlansViews = [easyPlan, mediumPlan, intensePlan]
        
        let views = trainingPlansViews + [continueButton, questionPrefixLabel, questionSuffixLabel]
        view.addMultipleSubviews(views)
        
        setDimensionConstraints(forViews: trainingPlansViews)
        setAxisConstraints()
        setQuestionPrefixLabelConstraints()
        setQuestionSuffixLabelConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.frame = CGRect(
            x: 16,
            y: view.bounds.maxY - 100,
            width: view.bounds.width - 32,
            height: 52
        )
        continueButton.layer.cornerRadius = continueButton.bounds.height/2
    }
    
    private func configureQuestions(prefix: String, suffix: String) {
        questionPrefixLabel.attributedText = prefix.formattedText(font: "Roboto-Light", size: 19, color: .white, kern: 0.23)
        questionSuffixLabel.attributedText = suffix.formattedText(font: "Oswald-Medium", size: 50, color: .white, kern: 0.59)
    }
    
    private func setAxisConstraints() {
        setEasyPlanAxisConstraints()
        setMediumPlanAxisConstraints()
        setIntensePlanAxisConstraints()
    }
    
    private func setDimensionConstraints(forViews views: [UIView] ) {
        views.forEach { (view) in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 122),
                view.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 60)
            ])
        }
    }
    
    private func setEasyPlanAxisConstraints() {
        easyPlan.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            easyPlan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            easyPlan.topAnchor.constraint(equalTo: view.topAnchor, constant: 320)
        ])
    }
    
    private func setMediumPlanAxisConstraints() {
        mediumPlan.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mediumPlan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mediumPlan.topAnchor.constraint(equalTo: easyPlan.bottomAnchor, constant: 16)
        ])
    }
    
    private func setIntensePlanAxisConstraints() {
        intensePlan.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            intensePlan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            intensePlan.topAnchor.constraint(equalTo: mediumPlan.bottomAnchor, constant: 16)
        ])
    }
    
    private func setQuestionPrefixLabelConstraints() {
        questionPrefixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionPrefixLabel.bottomAnchor.constraint(equalTo: self.questionSuffixLabel.topAnchor),
            questionPrefixLabel.leadingAnchor.constraint(equalTo: self.easyPlan.leadingAnchor)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionSuffixLabel.bottomAnchor.constraint(equalTo: easyPlan.topAnchor, constant: -16),
            questionSuffixLabel.leadingAnchor.constraint(equalTo: easyPlan.leadingAnchor)
        ])
    }
}
