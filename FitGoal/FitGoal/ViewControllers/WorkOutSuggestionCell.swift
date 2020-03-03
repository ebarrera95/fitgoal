//
//  WorkOutSuggestionCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 3/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class WorkOutSuggestionCell: UICollectionViewCell {
    
    static var indentifier: String = "WorkOutCell"
    
    var backgroundImage: UIImage?
    var titleLabel: UILabel?
    var subtitleLabel: UILabel?
    var addButton: UIButton?
    
    let cellWidth = 343
    let cellHeight = 116
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
