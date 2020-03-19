//
//  ExerciseMO+CoreDataClass.swift
//  FitGoal
//
//  Created by Eliany Barrera on 11/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ExerciseMO)
public class ExerciseMO: NSManagedObject {
    
    func getValue() -> Exercise {
        guard let name = self.name else { fatalError() }
        
        guard let textDescription = self.textDescription else { fatalError() }
        
        guard let stringURL = self.url else { fatalError() }
        guard let url = URL(string: stringURL) else { fatalError() }
        
        let id = Int(self.id)
        
        return Exercise(id: id, name: name, url: url, description: textDescription)
    }
    
    func copyValue(from exercise: Exercise) {
        self.id = Int32(exercise.id)
        self.name = exercise.name
        self.textDescription = exercise.description
        self.url = exercise.url.absoluteString
    }
}
