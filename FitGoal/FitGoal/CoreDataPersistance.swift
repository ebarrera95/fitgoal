//
//  ObjectContext.swift
//  FitGoal
//
//  Created by Eliany Barrera on 12/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit
import CoreData

protocol Persistence {
    func save(exercises: [Exercise])
    func readExercises() -> [Exercise]
    func clearData()
}

class CoreDataPersistance: Persistence {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FitGoal")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func save(exercises: [Exercise]) {
        do {
            exercises.forEach {
                let exerciseMO = ExerciseMO(context: persistentContainer.viewContext)
                exerciseMO.copyValue(from: $0)
            }
            try persistentContainer.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func readExercises() -> [Exercise] {
        do {
            let request: NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()
            return try persistentContainer.viewContext.fetch(request).map { $0.getValue() }
        }
        catch {
            print(error)
            return []
        }
    }
    
    func clearData() {
        do {
            let request: NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()
            let exercisesMO = try persistentContainer.viewContext.fetch(request)
            exercisesMO.forEach { persistentContainer.viewContext.delete($0) }
        }
        catch {
            print(error)
        }
    }
}
