//
//  HomeViewController + UICollectionViewDataSource.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        case 2:
            return workoutSuggestions.count
        default:
            return 0
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Suggestions", for: indexPath)
        if let suggestionCell = cell as? SuggestedRoutineCell {
            suggestionCell.title.text = workoutSuggestions[indexPath.row].name
            suggestionCell.subtitle.text = "\(workoutSuggestions[indexPath.row].excercices.count) NEW"
            return suggestionCell
        }
        return cell
    }
}

