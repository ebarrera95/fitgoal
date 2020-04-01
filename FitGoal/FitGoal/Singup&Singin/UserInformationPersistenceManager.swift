//
//  UserInformationPersistanceManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
struct UserInformationPersistenceManager {
    
    var userInfo: UserInformation?
    
    init(userInfo: UserInformation) {
        self.userInfo = userInfo
    }
    
    func saveUserInformation() {
        guard let userInfo = self.userInfo else { return }
        let defaults = UserDefaults.standard
        defaults.set(userInfo.name, forKey: UsersInfoKey.name.rawValue)
        defaults.set(userInfo.email, forKey: UsersInfoKey.email.rawValue)
    }
    
    static func isUserLogedIn() -> Bool {
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: UsersInfoKey.name.rawValue) != nil) &&
            (defaults.string(forKey: UsersInfoKey.email.rawValue) != nil) {
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
