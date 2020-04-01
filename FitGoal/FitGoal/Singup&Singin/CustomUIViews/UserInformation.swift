//
//  UserInformation.swift
//  FitGoal
//
//  Created by Eliany Barrera on 30/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation

struct UserInformation {
    let name: String
    let email: String
    
    func saveUserInformation() {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "UsersName")
        defaults.set(email, forKey: "UsersEmail")
    }
}
