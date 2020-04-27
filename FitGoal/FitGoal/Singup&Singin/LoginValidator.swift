//
//  LoginValidator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
class LoginValidator {
    
    var email: UserInfo = UserInfo(userInput: "", state: .valid) {
        didSet {
            email.state = validateUserEmailAddress(emailAddress: email.userInput)
        }
    }
    
    var password: UserInfo = UserInfo(userInput: "", state: .valid) {
        didSet {
            password.state = validatePassword(password: password.userInput)
        }
    }
    
    func isUserInputValid() -> Bool {
        return
            email.state == .valid &&
            password.state == .valid
    }
    
    private func validateUserName(name: String) -> UserInfoState {
        if name.isEmpty {
            return .invalid(invalidStateInfo: InvalidUserInfoState(message: "Enter your name", reason: .emptyField))
        } else {
            return .valid
        }
    }
    
    private func validateUserEmailAddress(emailAddress: String) -> UserInfoState {
        if emailAddress.isEmpty {
            return .invalid(invalidStateInfo: InvalidUserInfoState(message: "Enter your email address", reason: .emptyField))
        } else if !isEmailAddressValid(emailAddress: emailAddress) {
            return .invalid(invalidStateInfo: InvalidUserInfoState(message: "Invalid email address", reason: .incorrectInfo))
        } else {
            return .valid
        }
    }
    
    private func isEmailAddressValid(emailAddress: String) -> Bool {
        //validate email address
        return true
    }
    
    private func validatePassword(password: String) -> UserInfoState {
        if password.isEmpty {
            return .invalid(invalidStateInfo: InvalidUserInfoState(message: "Enter your password", reason: .emptyField))
        } else {
            return .valid
        }
    }
}
