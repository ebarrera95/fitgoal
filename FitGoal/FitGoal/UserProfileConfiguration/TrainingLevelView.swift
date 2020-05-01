//
//  TrainingLevelView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 30/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class TrainingLevelView: UIView {
    
    private let intensityLevelLabel = UILabel()
    private let trainingIntensityLabel = UILabel()
    
    private let eatingPlanLabel: UILabel = {
        let label = UILabel()
        let text = "Follow a flexible eating plan"
        label.attributedText = text.formattedText(font: "Roboto-Light", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.33)
        return label
    }()
    
    private let indicator: UIImageView = {
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
    
    init(level: String, monthTraining: Int, timesAWeek: Int, selectorStateColor: UIColor) {
        super.init(frame: .zero)
        trainingIntensityLabel.attributedText = trainingIntensityExplanationText(months: monthTraining, timesAWeek: timesAWeek)
        
        configureSelectionIndicator(for: isViewSelected)
        
        backgroundView.layer.borderColor = selectorStateColor.cgColor
        backgroundView.isHidden = true
        backgroundView.backgroundColor = selectorStateColor.withAlphaComponent(0.1)
        
        intensityLevelLabel.backgroundColor = selectorStateColor
        intensityLevelLabel.attributedText = intensityLevel(text: level)
        intensityLevelLabel.textAlignment = .center
        intensityLevelLabel.layer.masksToBounds = true
        
        let views = [
            backgroundView,
            intensityLevelLabel,
            trainingIntensityLabel,
            eatingPlanLabel,
            indicator,
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
    
    @objc private func handleTap() {
        if isViewSelected {
            isViewSelected = false
            configureSelectionIndicator(for: isViewSelected)
            backgroundView.isHidden = true
        } else {
            isViewSelected = true
            configureSelectionIndicator(for: isViewSelected)
            backgroundView.isHidden = false
        }
    }
    
    private func trainingIntensityExplanationText(months: Int, timesAWeek: Int) -> NSAttributedString {
        let text = "\(months) month training \(timesAWeek) times a week".uppercased()
        return text.formattedText(font: "Oswald-Medium", size: 21, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.17)
    }
    
    private func intensityLevel(text: String) ->
        NSAttributedString {
        return text.formattedText(font: "Roboto-Light", size: 12, color: .white, kern: 0.17)
    }
    
    
    private func configureSelectionIndicator(for selectedState: Bool) {
        if selectedState {
            indicator.image = UIImage(imageLiteralResourceName: "selectedIndicator")
        } else {
            indicator.image = UIImage(imageLiteralResourceName: "unselectedIndicator")
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
        setTrainingIntensityLevelLabelConstraints()
    }
    
    private func setIndicatorConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 27),
            indicator.heightAnchor.constraint(equalToConstant: 27),
            indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            indicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
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
    
    private func setTrainingIntensityLevelLabelConstraints() {
        trainingIntensityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trainingIntensityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            trainingIntensityLabel.topAnchor.constraint(equalTo: self.intensityLevelLabel.bottomAnchor, constant: 20),
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
