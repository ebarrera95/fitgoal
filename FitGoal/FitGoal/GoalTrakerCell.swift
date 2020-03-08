//
//  GoalTrakerCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GoalTrakerCell: UICollectionViewCell {
    static var identifier = "GoalTraker"
    var goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "GoalTraker")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(goalImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goalImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
