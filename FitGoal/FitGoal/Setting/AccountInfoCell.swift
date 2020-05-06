//
//  NotificationsCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 6/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AccountInfoCell: UITableViewCell {
    
    var cellTitle =  "" {
        didSet {
            cellTitleLabel.attributedText = cellTitle.formattedText(font: "Roboto-Light", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.3)
            if cellTitle == "Notifications" {
                self.accessoryView = switchControl
            } else if cellTitle == "Account Info" {
                self.accessoryType = .disclosureIndicator
                switchControl.isHidden = true
            }
        }
    }
    
    static let identifier = "NotificationsCell"
    
    let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)
        return switchControl
    }()
    
    let cellTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        let views = [cellTitleLabel, switchControl]
        contentView.addMultipleSubviews(views)
        setCellTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCellTitleConstraints() {
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            cellTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
