//
//  ExerciseDescriptionCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 15/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseDescriptionCell: UICollectionViewCell {
    
    static var identifier = "Exercise Description"
    
    var exercise: Exercise? {
        didSet {
            guard let textDesciption = exercise?.description else { return }
            let attributtedText = textDesciption.formattedText(
                font: "Roboto-Light",
                size: 15,
                color: #colorLiteral(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
                kern: 0.3,
                lineSpacing: 6
            )
            desciptionText.attributedText = attributtedText
        }
    }
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 7
        return view
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        let text = "DESCRIPTION"
        label.attributedText = text.formattedText(
            font: "Oswald-Medium",
            size: 16,
            color: #colorLiteral(red: 0.38, green: 0.39, blue: 0.38, alpha: 1),
            kern: 0.17
        )
        return label
    }()
    
    var desciptionText: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isScrollEnabled = false
        text.isSelectable = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(descriptionView)
        descriptionView.addSubview(desciptionText)
        descriptionView.addSubview(descriptionTitle)
        
        setDescriptionViewConstraints()
        setTextConstraints()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    //MARK: - Constraints
    
    private func setDescriptionViewConstraints() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }

    private func setTextConstraints() {
        desciptionText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            desciptionText.leadingAnchor.constraint(equalTo: descriptionTitle.leadingAnchor),
            desciptionText.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 8),
            desciptionText.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16),
            desciptionText.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setLabelConstraints() {
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTitle.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            descriptionTitle.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 16)
        ])
    }
    
    
    
    
}
