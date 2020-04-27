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
    var state = IconState.unselected
    
    var name: String {
        return iconType.rawValue.capitalized
    }
    
    var image: UIImage {
        switch iconType {
        case .athletic, .normal, .obese, .skinny:
            let coreName = "BodyShape"
            let bodyShapeImageName = iconType.prefix + coreName + state.suffix
            return UIImage(imageLiteralResourceName: bodyShapeImageName)
        case .female, .male:
            let genderImageName = iconType.prefix + state.suffix
            return UIImage(imageLiteralResourceName: genderImageName)
        }
    }

    private var isIconSelected: Bool {
        switch state {
        case .selected:
            return true
        case .unselected:
            return false
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

enum IconState: String {
    case selected
    case unselected
    
    var suffix: String {
        return self.rawValue.capitalized
    }
}
