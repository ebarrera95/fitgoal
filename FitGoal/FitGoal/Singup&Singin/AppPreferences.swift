//
//  UserInformationPersistanceManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
class AppPreferences {
    
    private let defaults = UserDefaults.standard
    
    var loggedInUser: UserIdentification? {
        get {
            guard let name = defaults.string(forKey: UsersInfoKey.name.rawValue) else { return nil }
            guard let email = defaults.string(forKey: UsersInfoKey.email.rawValue) else { return nil }
            return UserIdentification(name: name, email: email)
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
    
    var userGender: Gender? {
        get {
            return readEnum(forKey: UsersInfoKey.gender.rawValue)
        } set (userGender) {
            defaults.set(userGender?.rawValue, forKey: UsersInfoKey.gender.rawValue)
        }
    }
    
    var fitnessLevel: Fitness? {
        get {
            return readEnum(forKey: UsersInfoKey.fitnessLevel.rawValue)
        } set (userFitnessLevel) {
            defaults.set(userFitnessLevel?.rawValue, forKey: UsersInfoKey.fitnessLevel.rawValue)
        }
    }
    
    var fitnessGoal: Fitness? {
        get {
            return readEnum(forKey: UsersInfoKey.fitnessGoal.rawValue)
        } set (userFitnessGoal) {
            defaults.set(userFitnessGoal?.rawValue, forKey: UsersInfoKey.fitnessGoal.rawValue)
        }
    }
    
    var trainingIntensity: TrainingLevel? {
        get {
            return readEnum(forKey: UsersInfoKey.trainingIntensity.rawValue)
        } set (userTrainingIntensity) {
            defaults.set(userTrainingIntensity?.rawValue, forKey: UsersInfoKey.trainingIntensity.rawValue)
        }
    }
    
    var age: Int? {
        get {
            return defaults.value(forKey: UsersInfoKey.age.rawValue) as? Int
        } set (userAge) {
            defaults.set(userAge, forKey: UsersInfoKey.age.rawValue)
        }
    }
    
    var height: Int? {
        get {
            return defaults.value(forKey: UsersInfoKey.height.rawValue) as? Int
        } set (userHeight) {
            defaults.set(userHeight, forKey: UsersInfoKey.height.rawValue)
        }
    }
    
    var weight: Int? {
        get {
            return defaults.value(forKey: UsersInfoKey.weight.rawValue) as? Int
        } set (userWeight) {
            defaults.set(userWeight, forKey: UsersInfoKey.weight.rawValue)
        }
    }
    
    private func readEnum<T: RawRepresentable>(forKey key: String) -> T? where T.RawValue == String {
        guard let value = defaults.string(forKey: key) else { return nil }
        guard let parsedValue = T(rawValue: value) else {
            assertionFailure("value doesn't match raw representable")
            return nil
        }
        
        return parsedValue
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
