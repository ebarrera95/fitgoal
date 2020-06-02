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
    
    private let userPreference: UserPreference
    var newPreferenceValue: String? {
        didSet {
            guard let newPreference = newPreferenceValue else {
                return
            }
            save(preference: newPreference)
        }
    }
    
    var userOptions: [String] = []
    
    init(userPreference: UserPreference) {
        self.userPreference = userPreference
        self.userOptions = arrangeOptions(for: userPreference).map { $0.capitalized }
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
        
        for index in array.indices {
            if array[index] == userCase {
                array.remove(at: index)
                break
            }
        }
        array.insert(userCase, at: 0)
        return array.map { $0.rawValue }
    }
    
    private func save(preference newPreference: String) {
        switch self.userPreference.preferenceType {
        case .gender:
            guard let newGender = Gender(rawValue: newPreference.lowercased()) else {
                assertionFailure("value doesn't match raw representable")
                return
            }
            appPreferences.userGender = newGender
            userPreference.preferenceType = UserPreferenceType.gender(newGender)
        case .goal:
            guard let newGoal = Fitness(rawValue: newPreference.lowercased()) else {
                assertionFailure("value doesn't match raw representable")
                return
            }
            appPreferences.fitnessGoal = newGoal
            userPreference.preferenceType = UserPreferenceType.goal(newGoal)
        default:
            assertionFailure("No implementation has been made for this case")
            return
        }
    }
}
