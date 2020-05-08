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
    private let genderPicker = UIPickerView()
    
    private let optionsInPickerView = ["Male", "Female"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(genderPicker)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return optionsInPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionsInPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return contentView.bounds.height
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return contentView.bounds.width
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = optionsInPickerView[row]
        return title.formattedText(font: "Oswald-Light", size: 15, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), kern: 0.12)
    }
    
}
