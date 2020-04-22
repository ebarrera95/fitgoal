//
//  Images.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    case skinnyBodyShape
    case skinnyBodyShapeSelected
    case normalBodyShape
    case normalBodyShapeSelected
    case obeseBodyShape
    case obeseBodyShapeSelected
    case athleticBodyShape
    case athleticBodyShapeSelected
    case female
    case femaleSelected
    case male
    case maleSelected
    case next
    case unselectedIndicator
    case selectedIndicator

    var image: UIImage {
        switch self {
        case .skinnyBodyShape:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .skinnyBodyShapeSelected:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .normalBodyShape:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .normalBodyShapeSelected:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .obeseBodyShape:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .obeseBodyShapeSelected:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .athleticBodyShape:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .athleticBodyShapeSelected:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .female:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .femaleSelected:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .male:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .maleSelected:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .next:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .unselectedIndicator:
            return UIImage(imageLiteralResourceName: self.rawValue)
        case .selectedIndicator:
            return UIImage(imageLiteralResourceName: self.rawValue)
        }
    }
}

enum UserInfoSections {
    case gender
    case age
    case height
    case weight
    case fitnessLevel
    case fitnessGoal
    case trainLevel
}

enum IconState {
    case selected
    case unselected
}

enum BodyShape {
    case skinny(IconState)
    case normal(IconState)
    case obese(IconState)
    case athletic(IconState)
    
    var image: UIImage {
        switch self {
        case .skinny:
            return isBodyShapeSelected ? UIImage(imageLiteralResourceName: "skinnyBodyShapeSelected") : UIImage(imageLiteralResourceName: "skinnyBodyShape")
        case .normal:
            return isBodyShapeSelected ? UIImage(imageLiteralResourceName: "normalBodyShapeSelected") : UIImage(imageLiteralResourceName: "normalBodyShape")
        case .obese:
            return isBodyShapeSelected ? UIImage(imageLiteralResourceName: "obeseBodyShapeSelected") : UIImage(imageLiteralResourceName: "obeseBodyShape")
        case .athletic:
            return isBodyShapeSelected ? UIImage(imageLiteralResourceName: "athleticBodyShapeSelected") : UIImage(imageLiteralResourceName: "athleticBodyShape")
        }
    }
    
    private var isBodyShapeSelected: Bool {
        switch self {
        case .skinny(let state):
            return (state == .selected) ? true : false
        case .normal(let state):
            return (state == .selected) ? true : false
        case .obese(let state):
            return (state == .selected) ? true : false
        case .athletic(let state):
            return (state == .selected) ? true : false
        }
    }
    
    var name: String {
        switch self {
        case .skinny:
            return "Skinny"
        case .normal:
            return "Normal"
        case .obese:
            return "Obese"
        case .athletic:
            return "Athletic"
        }
    }
}
