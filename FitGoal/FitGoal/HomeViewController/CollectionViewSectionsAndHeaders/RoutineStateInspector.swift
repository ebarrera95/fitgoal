//
//  RoutineInspectoState.swift
//  FitGoal
//
//  Created by Eliany Barrera on 12/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

enum RoutineStateInspector {
    case inspecting([Exercise])
    case unset

    var didUserSelectRoutine: Bool {
        switch self {
        case .unset:
            return false
        case .inspecting:
            return true
        }
    }
}
