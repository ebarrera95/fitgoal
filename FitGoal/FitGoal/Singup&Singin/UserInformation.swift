//
//  UserInformation.swift
//  FitGoal
//
//  Created by Eliany Barrera on 30/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct UserInformation {
    let name: String
    let email: String
    
    func saveUserInformation() {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: UsersInfoKey.name.rawValue)
        defaults.set(email, forKey: UsersInfoKey.email.rawValue)
    }
    
    static func isUserLogedIn() -> Bool {
        if (UserDefaults.standard.string(forKey: UsersInfoKey.name.rawValue) != nil) && (UserDefaults.standard.string(forKey: UsersInfoKey.email.rawValue) != nil) {
            return true
        } else {
            return false
        }
    }
}

private enum UsersInfoKey: String {
    case name
    case email
}
