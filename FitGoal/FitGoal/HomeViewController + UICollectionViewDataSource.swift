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
        case .goalTracking, .routine:
            return 0
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
        case .goalTracking, .routine:
            fatalError("Configuration for cells should be handled here")
        case .suggestions:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "Suggestions", for: indexPath) as? SuggestedRoutineCell else {
                fatalError()
            }

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
            fatalError()
        case .routine:
            fatalError()
        case .suggestions:
            header.sectionName = "suggested"
            return header
        }
    }
}

enum HomeSection: Int {
    case goalTracking
    case routine
    case suggestions
}
