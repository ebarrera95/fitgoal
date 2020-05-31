//
//  UserInfoTextFieldDelegate.swift
//  FitGoal
//
//  Created by Eliany Barrera on 31/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserInfoTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private let appPreferences = AppPreferences()
    private let quantitativeUserInfo: QuantitativeUserInfo
    
    init(textField: UITextField, quantitativeUserInfo: QuantitativeUserInfo) {
        self.quantitativeUserInfo = quantitativeUserInfo
        super.init()
        textField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch quantitativeUserInfo {
        case .age:
            if let text = textField.text, let age = Int(text) {
                appPreferences.age = age
            }
        case .height:
            if let text = textField.text, let height = Int(text) {
                appPreferences.height = height
            }
        case .weight:
            if let text = textField.text, let weight = Int(text) {
                appPreferences.weight = weight
            }
        }
    }
}

enum QuantitativeUserInfo {
    case age
    case height
    case weight
}
