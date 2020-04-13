//
//  CustomAuthenticator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 10/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

class CustomAuthenticator {
    var userName: UserInfoField?
    var userEmail: UserInfoField?
    var password: UserInfoField?
    var passwordConfirmation: UserInfoField?
    
    var isUserInformationCorrect: Bool {
        return isUserInfoStateValid(userInfoField: userName) &&
            isUserInfoStateValid(userInfoField: userEmail) &&
            isUserInfoStateValid(userInfoField: password) &&
            isUserInfoStateValid(userInfoField: passwordConfirmation)
    }
    
    private func isUserInfoStateValid(userInfoField: UserInfoField?) -> Bool {
        if let field = userInfoField {
            switch field.state {
            case .valid:
                return true
            case .invalid:
                return false
            }
        } else {
            return false
        }
    }
}

enum UserInfoField {
    case userName(name: String)
    case userEmail(email: String)
    case password(password: String)
    case passwordConfirmation (passwordConfirmation: String)
    
    var state: UserInfoState {
        switch self {
        case .userName(let name):
            if name.isEmpty {
                return .invalid(reason: .emptyField(message: "Enter your name"))
            } else {
                return .valid
            }
        case .userEmail(let email):
            if email.isEmpty {
                return .invalid(reason: .emptyField(message: "Enter your email"))
            } else if !isEmailAddressValid(emailAddress: email) {
                return .invalid(reason: .incorrectInfo(message: "Invalid email address"))
            } else {
                return .valid
            }
        case .password(let password):
            if password.isEmpty {
                return .invalid(reason: .emptyField(message: "Enter password"))
            } else if !isPasswordValid(password: password) {
                return .invalid(reason: .incorrectInfo(message: "Invalid password"))
            } else {
                return .valid
            }
        case .passwordConfirmation(let confirmPassword):
            if confirmPassword.isEmpty {
                return .invalid(reason: .emptyField(message: "Confirm your password"))
            } else {
                return .valid
            }
        }
    }
    
    private func isEmailAddressValid(emailAddress: String) -> Bool {
        //validate email address
        return true
    }
    
    private func isPasswordValid(password: String) -> Bool {
        //validate password
        return true
    }
}

enum UserInfoState {
    case valid
    case invalid(reason: InvalidStateReason)
}

enum InvalidStateReason {
    case emptyField(message: String)
    case nonMatchingValues(message: String)
    case incorrectInfo(message: String)
    
    var retrieveMessage: String {
        switch self {
        case .emptyField(let message):
            return message
        case .incorrectInfo(let message):
            return message
        case .nonMatchingValues(let message):
            return message
        }
    }
}

    
