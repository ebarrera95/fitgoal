//
//  CustomAuthenticator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 10/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct UserInfo {
    var fieldName: String
    fileprivate var state: UserInfoState
}

class SignUpValidator {
    
    var name: UserInfo = UserInfo(fieldName: "", state: .valid) {
        didSet {
            name.state = validateUserName(name: name.fieldName)
        }
    }
    
    var email: UserInfo = UserInfo(fieldName: "", state: .valid) {
        didSet {
            email.state = validateUserEmailAddress(emailAddress: email.fieldName)
        }
    }
    
    var password: UserInfo = UserInfo(fieldName: "", state: .valid) {
        didSet {
            password.state = validatePassword(password: password.fieldName)
        }
    }
    
    var passwordConfirmation: UserInfo = UserInfo(fieldName: "", state: .valid) {
        didSet {
            passwordConfirmation.state = validatePasswordConfirmation(passwordConfirmation: passwordConfirmation.fieldName)
        }
    }
    
    func isUserInformationValid() -> Bool {
        return
            name.state == .valid &&
            email.state == .valid &&
            password.state == .valid &&
            passwordConfirmation.state == .valid
    }
    
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

enum UserInfoState: Equatable {
    case valid
    case invalid(invalidStateInfo: InvalidState)
}

extension UserInfoState {
    static func == (lhs: UserInfoState, rhs: UserInfoState) -> Bool {
        switch (lhs, rhs ){
        case (.valid, .valid):
            return true
        case (.invalid(let infoState1), .invalid(invalidStateInfo: let infoState2)):
            return infoState1 == infoState2
        default:
            return false
        }
    }
}


struct InvalidState: Equatable {
    let message: String
    let reason: Reason
}

enum Reason {
    case emptyField, incorrectInfo, nonMatchingValues
}
