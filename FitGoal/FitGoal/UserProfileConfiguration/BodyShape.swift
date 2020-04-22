//
//  Images.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

struct BodyShape {
    
    let shape: Shape
    
    var state = IconState.unselected
    
    var name: String {
        switch shape {
        case .athletic, .normal, .obese, .skinny:
            return shape.rawValue.capitalized
        }
    }
    
    var image: UIImage {
        let core = "BodyShape"
        let bodyShapeImageName = shape.prefix + core + state.suffix
        return UIImage(imageLiteralResourceName: bodyShapeImageName)
    }

    
    private var isBodyShapeSelected: Bool {
        switch state {
        case .selected:
            return true
        case .unselected:
            return false
        }
    }
}

enum Shape: String {
    case skinny
    case normal
    case obese
    case athletic
    
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
