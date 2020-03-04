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
            let title = workoutSuggestions[indexPath.row].name
            suggestionCell.title.attributedText = configureCellTitle(with: title)
            
            let numberOfExcercices = workoutSuggestions[indexPath.row].exercices.count
            let subtitle = "\(numberOfExcercices) new"
            suggestionCell.subtitle.attributedText = configureCellSubtitle(with: subtitle)
            let stringUrl = workoutSuggestions[indexPath.row].url
            guard let url = URL(string: stringUrl) else { return cell }
            let placeHolder = suggestionCell.placeholder
            placeHolder.isHidden = false
            placeHolder.startAnimating()
            self.fetchImage(with: url) { (image, error) in
                if let image = image {
                    DispatchQueue.main.async {
                        suggestionCell.backgroundImage.image = image
                        placeHolder.stopAnimating()// is this staying in memory?
                        placeHolder.isHidden = true
                        suggestionCell.gradientView.isHidden = false // is this staying in memory?
                    }
                }
            }
            return suggestionCell
        }
        return cell
    }
    
    func fetchImage(with url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            if let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func configureCellTitle(with string: String) -> NSAttributedString {
        let capString = string.localizedUppercase
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Roboto-Bold", size: 12)!,
            .foregroundColor: UIColor.white,
            .kern: 0.14
        ]
        let cellTitle = NSAttributedString(string: capString, attributes: atributes)
        return cellTitle
    }
    func configureCellSubtitle(with string: String) -> NSAttributedString {
        let capString = string.localizedLowercase
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Roboto-Regular", size: 9)!,
            .foregroundColor: UIColor.white,
            .kern: 0.11
        ]
        let cellTitle = NSAttributedString(string: capString, attributes: atributes)
        return cellTitle
    }
}
