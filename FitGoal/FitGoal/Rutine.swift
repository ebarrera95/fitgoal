//
//  Rutines.swift
//  FitGoal
//
//  Created by Eliany Barrera on 3/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct Rurine: Decodable {
    let name: String
    let url: String
    let exercices: [Exercice]
}
