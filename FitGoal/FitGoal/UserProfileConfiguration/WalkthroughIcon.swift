//
//  Images.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

struct WalkthroughIcon {
    
    let iconType: WalkThroughIconType
    var selected = false
    
    private var iconNameSuffix: String {
        if selected {
            return "Selected"
        } else {
            return "Unselected"
        }
    }
    
    private var iconNamePrefix: String {
        return name.lowercased()
    }
    
    var name: String {
        switch iconType {
        case .fitnessLevel(let fitnessLevel):
            return fitnessLevel.rawValue.capitalized
        case .gender(let gender):
            return gender.rawValue.capitalized
        }
    }
    
    var image: UIImage {
        switch iconType {
        case .fitnessLevel:
            let coreName = "BodyShape"
            let bodyShapeImageName = iconNamePrefix + coreName + iconNameSuffix
            return UIImage(imageLiteralResourceName: bodyShapeImageName)
        case .gender:
            let genderImageName = iconNamePrefix + iconNameSuffix
            return UIImage(imageLiteralResourceName: genderImageName)
        }
    }
}

enum WalkThroughIconType {
    case gender(gender: Gender)
    case fitnessLevel(fitnessLevel: FitnessLevel)
}
