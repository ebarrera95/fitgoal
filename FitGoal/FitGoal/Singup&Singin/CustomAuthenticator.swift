//
//  CustomAuthenticator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 10/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

class CustomAuthenticator {
    var userName: String?
    var userEmail: String?
    var password: String?
    var passwordConfirmation: String?
    
    func compare(password: String, with passwordConfirmation: String) -> Bool {
        if !password.isEmpty {
            return password == passwordConfirmation
        } else {
            return false
        }
    }
    
    func isEmailAddressValid(emailAddress: String) -> Bool {
        return true
    }
}
    
