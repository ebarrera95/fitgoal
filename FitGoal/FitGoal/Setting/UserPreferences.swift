//
//  UserPreferences.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

enum UserPreferenceType {
    case height(Int?)
    case weight(Int?)
    case age(Int?)
    case gender(Gender?)
    case goal(Fitness?)
    
    var preferenceName: String {
        switch self {
        case .age:
            return  "age"
        case .height:
            return "height"
        case .weight:
            return "weight"
        case .gender:
            return "gender"
        case .goal:
            return "goal"
        }
    }
}

class UserPreference {
    let preferenceType: UserPreferenceType
    let image: UIImage
    
    init(userPreferenceType: UserPreferenceType) {
        self.preferenceType = userPreferenceType
        self.image = UIImage(imageLiteralResourceName: userPreferenceType.preferenceName)
    }
    
    var preferenceName: String {
        return preferenceType.preferenceName.capitalized
    }
    
    var preferenceValue: String {
        let notSet = "Not Set"
        switch self.preferenceType {
        case .age(let age):
            return  (age != nil) ? String(age!) : notSet
        case .height(let height):
            return (height != nil) ? String(height!) : notSet
        case .weight(let weight):
            return (weight != nil) ? String(weight!) : notSet
        case .gender(let gender):
            return (gender != nil) ? String(gender!.rawValue.capitalized) : notSet
        case .goal(let fitnessGoal):
            return (fitnessGoal != nil) ? String(fitnessGoal!.rawValue.capitalized) : notSet
        }
    }
}
