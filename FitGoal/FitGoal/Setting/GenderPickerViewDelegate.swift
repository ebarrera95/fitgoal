//
//  SettingsUserInfoEditor.swift
//  FitGoal
//
//  Created by Eliany Barrera on 2/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class GenderPickerViewDelegate: NSObject,  UIPickerViewDelegate {
    
    let height: CGFloat
    
    init(frame: CGRect) {
        self.height = frame.height
        super.init()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return height
    }
}

class GenderPickerViewDataSource: NSObject, UIPickerViewDataSource {
    
    private let genderPicker: UIPickerView
    private let optionsInPickerView: [String]
    
    init(genderPicker: UIPickerView, dataSource: [String]) {
        self.genderPicker = genderPicker
        self.optionsInPickerView = dataSource
        super.init()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionsInPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = optionsInPickerView[row]
        let attributedTitle = title.formattedText(font: "Roboto-Regular", size: 12, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), kern: 0.12)
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedTitle)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: (title as NSString).length)
        mutableAttributedString.addAttributes([.paragraphStyle : paragraphStyle], range: range)
        return mutableAttributedString as NSAttributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gender = optionsInPickerView[row]
        //configureUserInformationLabel(withText: gender)
    }
}

class UserInfoSettingsEditor {
    
    private let userPreferenceType: UserPreferenceType
    var userOptions: [String] = []
    var userNewPreference: String?
    
    init(userPreferenceType: UserPreferenceType) {
        self.userPreferenceType = userPreferenceType
        self.userOptions = arrangeOptions(for: userPreferenceType)
    }
        
    private func arrangeOptions(for userPreferenceType: UserPreferenceType) -> [String] {
        switch userPreferenceType {
        case .gender(let gender):
            return arrangeOptions(forCase: gender)
        case .goal(let fitnessGoal):
            return arrangeOptions(forCase: fitnessGoal)
        default:
            assertionFailure("No implementation has been made for this case")
            return []
        }
    }
    
    private func arrangeOptions<T: CaseIterable & RawRepresentable & Equatable >(forCase userCase: T?) -> [T.RawValue] {
        
        var array = T.allCases
        guard let userCase = userCase else {
            return array.map { $0.rawValue }
        }
        
        array = array.drop { $0 == userCase } as! T.AllCases
        var rawValueArray = array.map { $0.rawValue }
        rawValueArray = rawValueArray + [userCase.rawValue]
        return rawValueArray
    }
}
