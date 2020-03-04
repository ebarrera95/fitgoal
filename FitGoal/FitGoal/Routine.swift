//
//  Routine.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct Routine: Decodable {
    var name: String
    var url: String
    var exercices: [Int]
}
