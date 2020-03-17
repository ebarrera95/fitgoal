//
//  ExerciseDetailViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    var exercise: Exercise?
    
    private var starExerciseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.56, green: 0.07, blue: 1, alpha: 1)
        let string = "Start Routine".formattedText(
        font: "Roboto-Regular",
        size: 17,
        color: .white,
        kern: 0)
        button.setAttributedTitle(string, for: .normal)
        
        return button
    }()
    
    private let exerciseCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(exerciseCollectionView)
        view.addSubview(starExerciseButton)
        
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        self.exerciseCollectionView.dataSource = self
        self.exerciseCollectionView.delegate = self
        self.exerciseCollectionView.alwaysBounceVertical = true
        self.exerciseCollectionView.backgroundColor = .clear
        
        exerciseCollectionView.register(ExercisePreviewCell.self, forCellWithReuseIdentifier: ExercisePreviewCell.identifier)
        
        exerciseCollectionView.register(ExerciseDescriptionCell.self, forCellWithReuseIdentifier: ExerciseDescriptionCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        exerciseCollectionView.frame = view.bounds
        starExerciseButton.frame = CGRect (x: 16, y: view.bounds.maxY - 84, width: view.bounds.width - 32, height: 54)
        starExerciseButton.layer.cornerRadius = starExerciseButton.bounds.height/2
    }
}
extension ExerciseDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let exerciseSection = ExerciseDetailSection(rawValue: section) else {
            fatalError("Section value should have a corresponding case in the HomeSection enum")
        }
        switch exerciseSection {
        case .preview:
            return 1
        case .description:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let exerciseSection = ExerciseDetailSection(rawValue: indexPath.section) else {
            fatalError("Section value should have a corresponding case in the HomeSection enum")
        }
        switch exerciseSection {
        case .preview:
            guard let cell = exerciseCollectionView.dequeueReusableCell(withReuseIdentifier: ExercisePreviewCell.identifier, for: indexPath) as? ExercisePreviewCell else { fatalError() }
            cell.exercise = exercise
            return cell
        case .description:
            guard let cell = exerciseCollectionView.dequeueReusableCell(withReuseIdentifier: ExerciseDescriptionCell.identifier, for: indexPath) as? ExerciseDescriptionCell else { fatalError() }
            cell.exercise = exercise
            return cell
        }
    }
}

extension ExerciseDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let exerciseSection = ExerciseDetailSection(rawValue: indexPath.section) else {
            fatalError("Section value should have a corresponding case in the HomeSection enum")
        }
        switch exerciseSection {
        case .preview:
            return CGSize(width: view.bounds.width - 32, height: 360)
        case .description:
            return CGSize(width: view.bounds.width - 32, height: 360)
        }
    }
    
}

enum ExerciseDetailSection: Int {
    case preview
    case description
}
