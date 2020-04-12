//
//  CustomAuthenticator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 10/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct CustomAuthenticator {
    let userName: String
    let userEmail: String
    let password: String
    let passwordConfirmation: String
    
    func compare(password: String, with passwordConfirmation: String) -> Bool {
        return password == passwordConfirmation
    }
}
    
