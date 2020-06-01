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
}

class UserPreference {
    let preferenceType: UserPreferenceType
    let image: UIImage
    
    init(userPreferenceType: UserPreferenceType) {
        self.preferenceType = userPreferenceType
        func preferenceImage() -> UIImage {
            switch userPreferenceType {
            case .height(_):
                return UIImage(imageLiteralResourceName: "height")
            case .weight(_):
                return UIImage(imageLiteralResourceName: "weight")
            case .age(_):
                return UIImage(imageLiteralResourceName: "age")
            case .gender(_):
                return UIImage(imageLiteralResourceName: "gender")
            case .goal(_):
                return UIImage(imageLiteralResourceName: "goal")
            }
        }
        self.image = preferenceImage()
    }
    
    func preferenceName() -> String {
        switch self.preferenceType {
        case .age(_):
            return  "Age"
        case .height(_):
            return "Height"
        case .weight(_):
            return "Weight"
        case .gender(_):
            return "Gender"
        case .goal(_):
            return "Goal"
        }
    }
    
    func preferenceValue() -> String {
        switch self.preferenceType {
        case .age(let age):
            return  (age != nil) ? String(age!) : "Not Set"
        case .height(let height):
            return (height != nil) ? String(height!) : "Not Set"
        case .weight(let weight):
            return (weight != nil) ? String(weight!) : "Not Set"
        case .gender(let gender):
            return (gender != nil) ? String(gender!.rawValue) : "Not Set"
        case .goal(let fitnessGoal):
            return (fitnessGoal != nil) ? String(fitnessGoal!.rawValue) : "Not Set"
        }
    }
}
