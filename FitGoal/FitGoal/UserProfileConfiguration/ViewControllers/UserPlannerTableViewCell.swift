//
//  UserPlannerTableViewCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserPlannerTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: self)
    
    var trainingProgram: TrainingProgram? {
        didSet {
            guard let trainingProgram = trainingProgram else { fatalError() }
            configureProgramIntensityLabel(for: trainingProgram)
            configureProgramDescriptionLabel(for: trainingProgram)
            configureEatingPlanDescriptionLabel(for: trainingProgram)
        }
    }
    
    private let programIntensityLabel = UILabel()
    private let programDescriptionLabel = UILabel()
    private let eatingPlanDescriptionLabel = UILabel()
    private let selectionIndicator = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        let views = [
            programIntensityLabel,
            programDescriptionLabel,
            eatingPlanDescriptionLabel,
            selectionIndicator,
        ]
        self.contentView.addMultipleSubviews(views)
        configureContentView()
        setUpShadow()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        programIntensityLabel.layer.cornerRadius = 10
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 7
    }
    
    private func setUpShadow() {
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
    
    private func configureProgramIntensityLabel(for trainingProgram: TrainingProgram) {
        programIntensityLabel.backgroundColor = selectedStateColor(for: trainingProgram)
        let text = trainingProgram.trainingLevel.rawValue
        programIntensityLabel.attributedText = text.formattedText(font: "Roboto-Light", size: 12, color: .white, kern: 0.17)
        programIntensityLabel.layer.masksToBounds = true
        programIntensityLabel.textAlignment = .center
    }
    
    private func configureProgramDescriptionLabel(for trainingProgram: TrainingProgram) {
        let text = "\(trainingProgram.monthsTraining) month training \(trainingProgram.weeklyFrequency) times a week".uppercased()
        programDescriptionLabel.attributedText = text.formattedText(font: "Oswald-Medium", size: 21, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.17)
    }
    
    private func configureEatingPlanDescriptionLabel(for trainingProgram: TrainingProgram) {
        let text = trainingProgram.eatingPlanDescription
        eatingPlanDescriptionLabel.attributedText = text.formattedText(font: "Roboto-Light", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.33)
    }
    
    private func configureSelectionIndicatorImage(forState selectedState: Bool) {
        selectionIndicator.contentMode = .scaleAspectFill
        if selectedState {
            selectionIndicator.image = UIImage(imageLiteralResourceName: "selectedIndicator")
        } else {
            selectionIndicator.image = UIImage(imageLiteralResourceName: "unselectedIndicator")
        }
    }
    
    private func selectedBackgroundView(for trainingProgram: TrainingProgram) -> UIView {
        let backgroundView = UIView()
        let color = selectedStateColor(for: trainingProgram)
        backgroundView.layer.borderColor = color.cgColor
        backgroundView.backgroundColor = color.withAlphaComponent(0.1)
        backgroundView.layer.cornerRadius = 7
        backgroundView.layer.borderWidth = 2
        return backgroundView
    }
    
    private func selectedStateColor(for trainingProgram: TrainingProgram) -> UIColor {
        switch trainingProgram.trainingLevel {
        case .easy:
            return #colorLiteral(red: 0.2431372549, green: 0.7803921569, blue: 0.9019607843, alpha: 1)
        case .medium:
            return #colorLiteral(red: 1, green: 0.6492816915, blue: 0.5106400314, alpha: 1)
        case .intense:
            return #colorLiteral(red: 0.9873231897, green: 0.1885731705, blue: 0.05805841231, alpha: 1)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureSelectionIndicatorImage(forState: selected)
        guard let trainingProgram = self.trainingProgram else { fatalError() }
        selectedBackgroundView = selectedBackgroundView(for: trainingProgram)
    }
    
    //MARK:- Constraints
    private func setConstraints() {
        setIndicatorConstraints()
        setProgramIntensityLabelConstraints()
        setEatingPlanDescriptionLabelConstraints()
        setProgramDescriptionLabelConstraints()
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
    
    private func setProgramIntensityLabelConstraints() {
        programIntensityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            programIntensityLabel.widthAnchor.constraint(equalToConstant: 60),
            programIntensityLabel.heightAnchor.constraint(equalToConstant: 20),
            programIntensityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            programIntensityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
    }
    
    private func setProgramDescriptionLabelConstraints() {
        programDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            programDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            programDescriptionLabel.topAnchor.constraint(equalTo: self.programIntensityLabel.bottomAnchor, constant: 20),
        ])
    }
    
    private func setEatingPlanDescriptionLabelConstraints() {
        eatingPlanDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eatingPlanDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            eatingPlanDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}

struct TrainingProgram {
    let trainingLevel: TrainingLevel
    let monthsTraining: Int
    let weeklyFrequency: Int
    let eatingPlanDescription = "Follow a flexible eating plan"
}

enum TrainingLevel: String {
    case easy
    case medium
    case intense
}
