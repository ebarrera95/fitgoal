//
//  GenderPickerViewCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GenderPickerViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static let identifier = "GenderPickerViewCell"
    private let genderPickerView = UIPickerView()
    
    private let optionsInPickerView = ["Male", "Female"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(genderPickerView)
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        setPickerViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func setPickerViewConstraints() {
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderPickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genderPickerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            genderPickerView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            genderPickerView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
