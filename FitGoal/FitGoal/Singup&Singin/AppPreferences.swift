//
//  UserInformationPersistanceManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
class AppPreferences {
    
    var loggedInUser: UserInformation? {
        get {
            let defaults = UserDefaults.standard
            guard let name = defaults.string(forKey: UsersInfoKey.name.rawValue) else { return nil }
            guard let email = defaults.string(forKey: UsersInfoKey.email.rawValue) else { return nil }
            return UserInformation(name: name, email: email)
        }
        set(userInfo) {
            let defaults = UserDefaults.standard
            if let userInfo = userInfo {
                defaults.set(userInfo.name, forKey: UsersInfoKey.name.rawValue)
                defaults.set(userInfo.email, forKey: UsersInfoKey.email.rawValue)
            } else {
                defaults.removeObject(forKey: UsersInfoKey.name.rawValue)
                defaults.removeObject(forKey: UsersInfoKey.email.rawValue)
            }
        }
    }
}

private enum UsersInfoKey: String {
    case name
    case email
}
