//
//  TrainingLevelView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 30/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol TrainingLevelViewDelegate: AnyObject {
    func userDidSelectTrainingLevel(trainingLevelView: TrainingLevelView)
}

class TrainingLevelView: UIView {
    
    weak var delegate: TrainingLevelViewDelegate?
    
    let userLevel: String
    
    private let intensityLevelLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        return label
    }()
    
    private let intensityLevelDescriptionLabel = UILabel()
    
    private let eatingPlanLabel: UILabel = {
        let label = UILabel()
        let text = "Follow a flexible eating plan"
        label.attributedText = text.formattedText(font: "Roboto-Light", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.33)
        return label
    }()
    
    private let selectionIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let background = UIView()
        background.layer.cornerRadius = 7
        background.layer.borderWidth = 2
        return background
    }()
    
    private var isViewSelected = false
    
    init(level: String, monthsTraining: Int, timesAWeek: Int, selectedStateColor: UIColor) {
        self.userLevel = level
        super.init(frame: .zero)
        intensityLevelDescriptionLabel.attributedText = intensityLevelDescriptionAttributedText(months: monthsTraining, timesAWeek: timesAWeek)
        configureSelectionIndicatorImage(forState: isViewSelected)
        
        backgroundView.layer.borderColor = selectedStateColor.cgColor
        backgroundView.isHidden = true
        backgroundView.backgroundColor = selectedStateColor.withAlphaComponent(0.1)
        
        intensityLevelLabel.backgroundColor = selectedStateColor
        intensityLevelLabel.attributedText = intensityLevelAttributedText(text: level)
        intensityLevelLabel.textAlignment = .center
        
        let views = [
            backgroundView,
            intensityLevelLabel,
            intensityLevelDescriptionLabel,
            eatingPlanLabel,
            selectionIndicator,
        ]
        self.addMultipleSubviews(views)
        
        backgroundColor = .white
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        setConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deselectView() {
        isViewSelected = false
        configureSelectionIndicatorImage(forState: isViewSelected)
        backgroundView.isHidden = true
    }
    
    private func selectView() {
        isViewSelected = true
        configureSelectionIndicatorImage(forState: isViewSelected)
        backgroundView.isHidden = false
    }
    
    @objc private func handleTap() {
        if isViewSelected {
            deselectView()
        } else {
            selectView()
            delegate?.userDidSelectTrainingLevel(trainingLevelView: self)
        }
    }
    
    private func intensityLevelDescriptionAttributedText(months: Int, timesAWeek: Int) -> NSAttributedString {
        let text = "\(months) month training \(timesAWeek) times a week".uppercased()
        return text.formattedText(font: "Oswald-Medium", size: 21, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.17)
    }
    
    private func intensityLevelAttributedText(text: String) ->
        NSAttributedString {
        return text.formattedText(font: "Roboto-Light", size: 12, color: .white, kern: 0.17)
    }
    
    
    private func configureSelectionIndicatorImage(forState selectedState: Bool) {
        if selectedState {
            selectionIndicator.image = UIImage(imageLiteralResourceName: "selectedIndicator")
        } else {
            selectionIndicator.image = UIImage(imageLiteralResourceName: "unselectedIndicator")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        intensityLevelLabel.layer.cornerRadius = intensityLevelLabel.bounds.height/2
        backgroundView.frame = self.bounds
    }
    
    //MARK: -Constraints
    
    private func setConstraints() {
        setIndicatorConstraints()
        setIntensityLevelLabelConstraints()
        setEatingPlanLabelConstraints()
        setIntensityLevelDescriptionLabelConstraints()
    }
    
    private func setIndicatorConstraints() {
        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectionIndicator.widthAnchor.constraint(equalToConstant: 27),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 27),
            selectionIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            selectionIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
        ])
    }
    
    private func setIntensityLevelLabelConstraints() {
        intensityLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            intensityLevelLabel.widthAnchor.constraint(equalToConstant: 60),
            intensityLevelLabel.heightAnchor.constraint(equalToConstant: 20),
            intensityLevelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            intensityLevelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
    }
    
    private func setIntensityLevelDescriptionLabelConstraints() {
        intensityLevelDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            intensityLevelDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            intensityLevelDescriptionLabel.topAnchor.constraint(equalTo: self.intensityLevelLabel.bottomAnchor, constant: 20),
        ])
    }
    
    private func setEatingPlanLabelConstraints() {
        eatingPlanLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eatingPlanLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            eatingPlanLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
