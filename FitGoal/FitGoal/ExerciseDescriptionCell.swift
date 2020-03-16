//
//  ExerciseDescriptionCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 15/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseDescriptionCell: UICollectionViewCell {
    static var identifier = "Exercise Description"
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    
}
