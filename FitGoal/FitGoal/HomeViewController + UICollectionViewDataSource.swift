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
        guard let homeSection = HomeSection(rawValue: section) else {
            fatalError("Section value should have a corresponding case in the HomeSection enum")
        }

        switch homeSection {
        case .goalTracking:
            return 1
        case  .routine:
            return 1
        case .suggestions:
            return workoutSuggestions.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {
            fatalError()
        }

        // TODO: Improve cell dequeue once other sections are handle
        switch homeSection {
        case .goalTracking:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "GoalTraker", for: indexPath) as? GoalTrakerCell else {
                fatalError()
            }
            return cell
        case .routine:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "Routines Cell", for: indexPath) as? RoutinesCell else {
                fatalError()
            }
            
            if let toDisplay = self.toDisplay {
                cell.routine = toDisplay
            }
            
            return cell
        case .suggestions:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "Suggestions", for: indexPath) as? SuggestedRoutineCell else {
                fatalError()
            }
            
            cell.delegate = self
            cell.routine = workoutSuggestions[indexPath.item]
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView
            .dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RoutineSectionHeader.identifier,
                for: indexPath
            ) as? RoutineSectionHeader,
            let homeSection = HomeSection(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch homeSection {
        case .goalTracking:
            header.sectionName = "Progress"
            return header
        case .routine:
            header.sectionName = "Explore Routine"
            header.link.isHidden = true
            return header
        case .suggestions:
            header.sectionName = "All Routines"
            return header
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 2 {
//            guard let cell = homeCollectionView.cellForItem(at: indexPath) as? SuggestedRoutineCell else { return }
//            let routine = cell.routine
//            exCell.routine = routine
//            collectionView.reloadData()
//        }
//        
//    }
}

enum HomeSection: Int {
    case goalTracking
    case routine
    case suggestions
}
