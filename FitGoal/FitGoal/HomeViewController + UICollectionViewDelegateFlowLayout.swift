//
//  HomeViewController + UICollectionViewDelegateFlowLayout .swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch homeSection {
        case .goalTracking:
           return CGSize(width: view.bounds.width - 32, height: 320)
        case .routine:
            switch routineDetails {
            case .vissible:
                return CGSize(width: view.bounds.width - 32, height: 230)
            case .hidden:
                return .zero
            }
        case .suggestions:
            return CGSize(width: view.bounds.width - 32, height: 140)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let homeSection = HomeSection(rawValue: section) else {
            fatalError()
        }
        
        switch homeSection {
        case .goalTracking:
            return .zero
        case .routine:
            switch routineDetails {
            case .vissible:
                return CGSize(width: view.bounds.width - 32, height: 72)
            case .hidden:
                return .zero
            }
        case .suggestions:
            return CGSize(width: view.bounds.width - 32, height: 72)
        }
    }
    
}
