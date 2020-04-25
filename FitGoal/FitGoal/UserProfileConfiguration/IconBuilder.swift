//
//  Images.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

struct IconBuilder {
    
    let icon: Icon
    var state = IconState.unselected
    
    var name: String {
        return icon.rawValue.capitalized
    }
    
    var image: UIImage {
        switch icon {
        case .athletic, .normal, .obese, .skinny:
            let coreName = "BodyShape"
            let bodyShapeImageName = icon.prefix + coreName + state.suffix
            return UIImage(imageLiteralResourceName: bodyShapeImageName)
        case .female, .male:
            let genderImageName = icon.prefix + state.suffix
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

enum Icon: String {
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
