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
    
    var userGender: String? {
        get {
            let defaults = UserDefaults.standard
            guard let gender = defaults.string(forKey: UsersInfoKey.gender.rawValue) else { return nil }
            return gender
        } set (userGender) {
            let defaults = UserDefaults.standard
            if let gender = userGender {
                defaults.set(gender, forKey: UsersInfoKey.name.rawValue)
            }
        }
    }
    
    var fitnessLevel: String? {
        get {
            let defaults = UserDefaults.standard
            guard let gender = defaults.string(forKey: UsersInfoKey.gender.rawValue) else { return nil }
            return gender
        } set (userFitnessLevel) {
            let defaults = UserDefaults.standard
            if let fitnessLevel = userFitnessLevel {
                defaults.set(fitnessLevel, forKey: UsersInfoKey.name.rawValue)
            }
        }
    }
    
}

private enum UsersInfoKey: String {
    case name
    case email
    case gender
    case fitnessLevel
    case fitnessGoal
    case age
    case height
    case weight
    case trainingIntensity
}
