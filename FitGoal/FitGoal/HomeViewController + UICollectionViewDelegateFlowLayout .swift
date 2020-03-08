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
            return .zero
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
        case .goalTracking, .routine:
            return .zero
        case .suggestions:
            return CGSize(width: view.bounds.width - 32, height: 72)
        }
    }
}
