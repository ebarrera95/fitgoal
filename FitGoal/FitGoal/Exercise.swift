//
//  Exercise.swift
//  FitGoal
//
//  Created by Eliany Barrera on 3/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct Exercice: Decodable {
    let id: Int
    let name: String
    let url: String
    let description: String
}
