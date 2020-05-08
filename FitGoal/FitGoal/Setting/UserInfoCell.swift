//
//  UserInfoCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 5/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
            if cellInfo.cellName == "Gender" {
                userInformation.inputView = genderPickerView
                userInformation.tintColor = .clear
            } else {
                userInformation.isUserInteractionEnabled = false
            }
        }
    }
    
    private let optionsInPickerView = ["Male", "Female"]
    
    static let identifier = "UserInfoCell"
    private let icon = UIImageView()
    private let cellTitle = UILabel()
    private let userInformation = UITextField()
    
    private let genderPickerView = UIPickerView()
    
    var userWillEditCell = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let views = [icon, cellTitle, userInformation]
        contentView.addMultipleSubviews(views)
        setConstraints()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
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

    private func setConstraints() {
        setIconConstraints()
        setCellTitleConstraints()
        setUserInformationConstraints()
        setPickerViewConstraints()
    }
    
    private func setIconConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
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
    
    private func setPickerViewConstraints() {
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderPickerView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension UserInfoCell {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionsInPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return contentView.bounds.height
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = optionsInPickerView[row]
        let mutableAttributedString = NSMutableAttributedString(attributedString: title.formattedText(font: "Roboto-Regular", size: 12, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), kern: 0.12))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: (title as NSString).length)
        mutableAttributedString.addAttributes([.paragraphStyle : paragraphStyle], range: range)
        return mutableAttributedString as NSAttributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gender = optionsInPickerView[row]
        configureUserInformationLabel(withText: gender)
        self.resignFirstResponder()
    }
}
