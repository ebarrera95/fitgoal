//
//  UserInformation.swift
//  FitGoal
//
//  Created by Eliany Barrera on 28/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

enum Gender: String, CaseIterable {
    case male
    case female
}

enum Fitness: String, CaseIterable {
    case skinny
    case normal
    case obese
    case athletic
}

enum TrainingLevel: String {
    case easy
    case medium
    case intense
}
