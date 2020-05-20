//
//  UserInformationPersistanceManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
class AppPreferences {
    
    let defaults = UserDefaults.standard
    
    var loggedInUser: UserInformation? {
        get {
            guard let name = defaults.string(forKey: UsersInfoKey.name.rawValue) else { return nil }
            guard let email = defaults.string(forKey: UsersInfoKey.email.rawValue) else { return nil }
            return UserInformation(name: name, email: email)
        }
        set(userInfo) {
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
            guard let gender = defaults.string(forKey: UsersInfoKey.gender.rawValue) else { return nil }
            return gender
        } set (userGender) {
            if let gender = userGender {
                defaults.set(gender, forKey: UsersInfoKey.name.rawValue)
            }
        }
    }
    
    var fitnessLevel: String? {
        get {
            guard let fitnessLevel = defaults.string(forKey: UsersInfoKey.fitnessLevel.rawValue) else { return nil }
            return fitnessLevel
        } set (userFitnessLevel) {
            if let fitnessLevel = userFitnessLevel {
                defaults.set(fitnessLevel, forKey: UsersInfoKey.name.rawValue)
            }
        }
    }
    
    var fitnessGoal: String? {
        get {
            guard let fitnessGoal = defaults.string(forKey: UsersInfoKey.fitnessGoal.rawValue) else { return nil }
            return fitnessGoal
        } set (userFitnessGoal) {
            if let fitnessGoal = userFitnessGoal {
                defaults.set(fitnessGoal, forKey: UsersInfoKey.fitnessGoal.rawValue)
            }
        }
    }
    
    var trainingIntensity: String? {
        get {
            guard let trainingIntensity = defaults.string(forKey: UsersInfoKey.trainingIntensity.rawValue) else { return nil }
            return trainingIntensity
        } set (trainingIntensity) {
            if let trainingIntensity = trainingIntensity {
                defaults.set(trainingIntensity, forKey: UsersInfoKey.trainingIntensity.rawValue)
            }
        }
    }
    
    var age: Int? {
        get {
            guard let age = defaults.value(forKey: UsersInfoKey.age.rawValue) as? Int else { return nil }
            return age
        } set (age) {
            if let age = age {
                defaults.set(age, forKey: UsersInfoKey.age.rawValue)
            }
        }
    }
    
    var height: Int? {
        get {
            guard let height = defaults.value(forKey: UsersInfoKey.height.rawValue) as? Int else { return nil }
            return height
        } set (height) {
            if let height = height {
                defaults.set(height, forKey: UsersInfoKey.height.rawValue)
            }
        }
    }
    
    var weight: Int? {
        get {
            guard let weight = defaults.value(forKey: UsersInfoKey.weight.rawValue) as? Int else { return nil }
            return weight
        } set (weight) {
            if let weight = weight {
                defaults.set(weight, forKey: UsersInfoKey.weight.rawValue)
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
