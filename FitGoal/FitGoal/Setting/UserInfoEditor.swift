//
//  SettingsUserInfoEditor.swift
//  FitGoal
//
//  Created by Eliany Barrera on 2/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserInfoEditor {
    
    private let appPreferences = AppPreferences()
    
    private let oldPreference: UserPreference
    var newPreference: String? {
        didSet {
            guard let newPreference = newPreference else {
                return
            }
            save(preference: newPreference)
        }
    }
    
    var userOptions: [String] = []
    
    init(userPreference: UserPreference) {
        self.oldPreference = userPreference
        self.userOptions = arrangeOptions(for: userPreference)
    }
        
    private func arrangeOptions(for userPreference: UserPreference) -> [String] {
        switch userPreference.preferenceType {
        case .gender(let gender):
            return arrangeOptions(forCase: gender)
        case .goal(let fitnessGoal):
            return arrangeOptions(forCase: fitnessGoal)
        default:
            assertionFailure("No implementation has been made for this case")
            return []
        }
    }
    
    private func arrangeOptions<T: CaseIterable & RawRepresentable & Equatable >(forCase userCase: T?) -> [T.RawValue] {
        
        var array = Array(T.allCases)
        guard let userCase = userCase else {
            return array.map { $0.rawValue }
        }
        
        array = Array(array.drop { $0 == userCase })
        print(array)
        var rawValueArray = array.map { $0.rawValue }
        rawValueArray = rawValueArray + [userCase.rawValue]
        return rawValueArray
    }
    
    private func save(preference newPreference: String) {
        switch self.oldPreference.preferenceType {
        case .gender:
            guard let newGender = Gender(rawValue: newPreference) else {
                assertionFailure("value doesn't match raw representable")
                return
            }
            appPreferences.userGender = newGender
        case .goal:
            guard let newGoal = Fitness(rawValue: newPreference) else {
                assertionFailure("value doesn't match raw representable")
                return
            }
            appPreferences.fitnessGoal = newGoal
        default:
            assertionFailure("No implementation has been made for this case")
            return
        }
    }
}
