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
            //Configure Title
            let title = workoutSuggestions[indexPath.row].name
            suggestionCell.title.attributedText = configureCellTitle(with: title)
            
            //Configure Subtitle
            let numberOfExcercices = workoutSuggestions[indexPath.row].exercices.count
            let subtitle = "\(numberOfExcercices) new"
            suggestionCell.subtitle.attributedText = configureCellSubtitle(with: subtitle)
            
            //Configure Image
            let stringUrl = workoutSuggestions[indexPath.row].url
            suggestionCell.imageURL = stringUrl
            
            return suggestionCell
        }
        
        return cell
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

extension UIImage {
    static func loadImage(from stringURL: String ,completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: stringURL) else { return }
        if let image =  imageCache[url] {
            completion(image)
        } else {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                if let image = UIImage(data: data) {
                    imageCache[url] = image
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }
}

