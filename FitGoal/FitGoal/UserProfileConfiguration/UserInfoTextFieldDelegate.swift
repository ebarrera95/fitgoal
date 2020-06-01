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
        guard let text = textField.text, let value = Int(text) else {
            assertionFailure("value must be and Int")
            return
        }
        switch quantitativeUserInfo {
        case .age:
            appPreferences.age = value
        case .height:
            appPreferences.height = value
        case .weight:
            appPreferences.weight = value
        }
    }
}

enum QuantitativeUserInfo {
    case age
    case height
    case weight
}
