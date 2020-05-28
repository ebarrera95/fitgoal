//
//  UserPlannerViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserPlannerViewController: UIViewController {
    
    private let tableViewRowHeight: CGFloat = 122
    
    private let tableViewDataSource = UserPlannerTableViewDataSource()
    private let tableViewDelegate = UserPlannerTableViewDelegate()
    private let tableView = UITableView()
    
    private let questionPrefixLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "How hard do you want to".formattedText(font: "Roboto-Light", size: 19, color: .white, kern: 0.23)
        return label
    }()
    
    private let questionSuffixLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "train".uppercased().formattedText(font: "Oswald-Medium", size: 50, color: .white, kern: 0.59)
        return label
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let views = [
            questionPrefixLabel,
            questionSuffixLabel,
            tableView,
            continueButton
        ]
        
        view.addMultipleSubviews(views)
        setConstraints()
        configureTableView()
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
    
    func setConstraints() {
        setQuestionSuffixLabelConstraints()
        setQuestionPrefixLabelConstraints()
        setTableViewConstraints()
    }
    
    private func configureTableView() {
        tableView.register(UserPlannerTableViewCell.self, forCellReuseIdentifier: UserPlannerTableViewCell.identifier)
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableView.rowHeight = tableViewRowHeight
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
    }
    
    private func setQuestionPrefixLabelConstraints() {
        questionPrefixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionPrefixLabel.bottomAnchor.constraint(equalTo: self.questionSuffixLabel.topAnchor),
            questionPrefixLabel.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionSuffixLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16),
            questionSuffixLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
