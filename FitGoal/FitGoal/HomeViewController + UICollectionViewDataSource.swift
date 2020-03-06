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
        switch indexPath.section {
        case 2:
            if let suggestionCell = cell as? SuggestedRoutineCell {
                suggestionCell.routine = workoutSuggestions[indexPath.row]
                return suggestionCell
            }
        default:
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RoutineCellHeader", for: indexPath)
        if let sectionHeader = header as? RoutineSectionHeader {
            switch indexPath.section {
            case 1:
                sectionHeader.sectionName = nil
                sectionHeader.link.isHidden = true
                return sectionHeader
            case 2:
                sectionHeader.sectionName = "suggested"
                sectionHeader.link.isHidden = false
                return sectionHeader
            default:
                return header
            }
        }
        return header
    }
}

