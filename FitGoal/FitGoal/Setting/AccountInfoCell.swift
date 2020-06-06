//
//  NotificationsCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 6/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AccountInfoCell: UITableViewCell {
    
    var cellType: AccountInfoCellType? {
        didSet {
            guard let cellType = cellType else { return }
            cellTitleLabel.attributedText = cellType.name.formattedText(font: "Roboto-Light", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.3)
            
            switch cellType {
            case .notifications(accessoryView: let accessoryView):
                self.accessoryView = accessoryView
            case .accountInfo(accessoryType: let accessoryType):
                self.accessoryType = accessoryType
            }
        }
    }
    
    static let identifier = "NotificationsCell"
    
    private let cellTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        let views = [cellTitleLabel]
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
