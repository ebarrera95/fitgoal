//
//  UserInfoCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 5/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol UserInfoCellDelegate: AnyObject {
    func userWillEditCell()
    func userDidEditCell()
}

class UserInfoCell: UITableViewCell {
    
    weak var delegate: UserInfoCellDelegate?
    
    var cellInformation: CellInformation? {
        didSet {
            guard let cellInfo = cellInformation else {
                assertionFailure("no cellInfo found")
                return
            }
            icon.image = cellInfo.cellIcon
            configureCellTitle(withText: cellInfo.cellName)
            configureUserInformationLabel(withText: cellInfo.userInformation)
            if cellInfo.cellName == "Goals" {
                self.accessoryType = .disclosureIndicator
                userInformation.isHidden = true
            }
        }
    }
    
    static let identifier = "UserInfoCell"
    private let icon = UIImageView()
    private let cellTitle = UILabel()
    private let userInformation = UILabel()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.isHidden = false
        return button
    }()
    
    private var userWillEditCell = false
    
    private var iconLeadingConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let views = [icon, cellTitle, userInformation, editButton]
        contentView.addMultipleSubviews(views)
        setConstraints()
        editButton.addTarget(self, action: #selector(handleEditTap), for: .touchUpInside)
        editButton.setAttributedTitle("Edit".formattedText(font: "Oswald-Medium", size: 15, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), kern: 0.3), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellTitle(withText text: String) {
        cellTitle.attributedText = text.formattedText(font: "Roboto-Light", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.3)
    }
    
    private func configureUserInformationLabel(withText text: String) {
        userInformation.attributedText = text.formattedText(font: "Roboto-Bold", size: 15, color: #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1), kern: 0.3)
    }
    
    @objc private func handleEditTap() {
        userWillEditCell = !userWillEditCell
        if userWillEditCell {
            editButton.setAttributedTitle("Done".formattedText(font: "Oswald-Medium", size: 15, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), kern: 0.3), for: .normal)
            self.delegate?.userWillEditCell()
        } else {
            editButton.setAttributedTitle("Edit".formattedText(font: "Oswald-Medium", size: 15, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), kern: 0.3), for: .normal)
            self.delegate?.userDidEditCell()
        }
    }
    
    private func setConstraints() {
        setIconConstraints()
        setCellTitleConstraints()
        setUserInformationConstraints()
        setEditButtonConstraints()
    }
    
    private func setIconConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.editButton.trailingAnchor, constant: 8),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 50),
            icon.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setCellTitleConstraints() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            cellTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    private func setUserInformationConstraints() {
        userInformation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInformation.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16),
            userInformation.centerYAnchor.constraint(lessThanOrEqualTo: self.contentView.centerYAnchor)
        ])
    }
    
    private func setEditButtonConstraints() {
        if !editButton.isHidden {
            editButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                editButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
                editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                editButton.heightAnchor.constraint(equalToConstant: 30),
                editButton.widthAnchor.constraint(equalToConstant: 30)
            ])
        }
    }
}
