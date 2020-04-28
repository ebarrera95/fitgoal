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
    
    var name: String {
        return iconType.rawValue.capitalized
    }
    
    var image: UIImage {
        switch iconType {
        case .athletic, .normal, .obese, .skinny:
            let coreName = "BodyShape"
            let bodyShapeImageName = iconType.prefix + coreName + iconNameSuffix
            return UIImage(imageLiteralResourceName: bodyShapeImageName)
        case .female, .male:
            let genderImageName = iconType.prefix + iconNameSuffix
            return UIImage(imageLiteralResourceName: genderImageName)
        }
    }
}

enum WalkThroughIconType: String {
    case skinny
    case normal
    case obese
    case athletic
    case female
    case male
    
    var prefix: String {
        return self.rawValue
    }
}
