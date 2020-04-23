//
//  TextFieldType.swift
//  FitGoal
//
//  Created by Eliany Barrera on 22/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

enum TextFieldType {
    case userName
    case emailAddress
    case password
    case confirmPassword
    
   var placeholder: String {
        switch self {
        case .userName:
            return "Name"
        case .emailAddress:
            return "Email"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
    
    var textContentType: UITextContentType {
        switch self {
        case .userName:
            return .name
        case .emailAddress:
            return .emailAddress
        case .password:
            return .password
        case .confirmPassword:
            return .password
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        switch self {
        case .userName:
            return .sentences
        case .emailAddress, .password, .confirmPassword:
            return .none
        }
    }
    
    var isSecureTextEntry: Bool {
        switch self {
        case .userName, .emailAddress:
            return false
        case .password, .confirmPassword:
            return true
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .userName, .password, .confirmPassword:
            return .default
        case .emailAddress:
            return .emailAddress
        }
    }
}
