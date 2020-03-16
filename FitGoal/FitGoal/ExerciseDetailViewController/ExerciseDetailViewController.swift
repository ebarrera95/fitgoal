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
    
    let exerciseCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //TODO: Remember to pass this view in the segue
    private var gradientView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(exerciseCollectionView)
        view.addSubview(gradientView)
        
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
        gradientView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
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
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = exerciseCollectionView.dequeueReusableCell(withReuseIdentifier: ExercisePreviewCell.identifier, for: indexPath) as? ExercisePreviewCell else { fatalError() }
        guard let exerciseSection = ExerciseDetailSection(rawValue: indexPath.section) else {
            fatalError("Section value should have a corresponding case in the HomeSection enum")
        }
        switch exerciseSection {
        case .preview:
            return cell
        case .description:
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
            return .zero
        }
    }
}

enum ExerciseDetailSection: Int {
    case preview
    case description
}
