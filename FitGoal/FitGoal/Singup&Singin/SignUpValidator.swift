//
//  CustomAuthenticator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 10/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

class SignUpValidator {
    
    var name: String = "" {
        didSet {
            userInfoState = validateUserName(name: name)
        }
    }
    
    var email: String = "" {
        didSet {
            userInfoState = validateUserEmailAddress(emailAddress: email)
        }
    }
    
    var password: String = "" {
        didSet {
            userInfoState = validatePassword(password: password)
        }
    }
    
    var passwordConfirmation: String = "" {
        didSet {
            userInfoState = validatePasswordConfirmation(passwordConfirmation: passwordConfirmation)
        }
    }
    
    
    var userInfoState = UserInfoState.valid
    
    private func validateUserName(name: String) -> UserInfoState {
        if name.isEmpty {
            return .invalid(invalidStateInfo: InvalidState(message: "Enter your name", reason: .emptyField))
        } else {
            return .valid
        }
    }
    
    private func validateUserEmailAddress(emailAddress: String) -> UserInfoState {
        if emailAddress.isEmpty {
            return .invalid(invalidStateInfo: InvalidState(message: "Enter your email address", reason: .emptyField))
        } else if !isEmailAddressValid(emailAddress: emailAddress) {
            return .invalid(invalidStateInfo: InvalidState(message: "Invalid email address", reason: .incorrectInfo))
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
            return .invalid(invalidStateInfo: InvalidState(message: "Enter your password", reason: .emptyField))
        } else if !isPasswordValid(password: password) {
            return .invalid(invalidStateInfo: InvalidState(message: "Invalid password", reason: .incorrectInfo))
        } else {
            return .valid
        }
    }
    
    private func isPasswordValid(password: String) -> Bool {
        //validate password
        return true
    }
    
    private func validatePasswordConfirmation(passwordConfirmation: String) -> UserInfoState {
        if passwordConfirmation.isEmpty {
            return .invalid(invalidStateInfo: InvalidState(message: "Confirm your password", reason: .emptyField))
        } else {
            return .valid
        }
    }
    
    private func doPasswordsMatch(password: String, passwordConfirmation: String) -> Bool {
        return true
    }
}

enum UserInfoState {
    case valid
    case invalid(invalidStateInfo: InvalidState)
}

struct InvalidState {
    let message: String
    let reason: Reason
}

enum Reason {
    case emptyField, incorrectInfo, nonMatchingValues
}
