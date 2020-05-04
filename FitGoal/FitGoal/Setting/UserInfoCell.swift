//
//  UserInfoCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 2/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    static let identifier = "UserInfoCell"
    let icon = UIImageView()
    let mainLabel = UILabel()
    let userInfo = UILabel()
    
//    init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
