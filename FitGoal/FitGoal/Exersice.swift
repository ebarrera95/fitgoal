//
//  Exersice.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct Exercise: Decodable, Hashable {
    var id: Int
    var name: String
    var url: URL
    var description: String
}
