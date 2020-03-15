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
    func saveData(exercises: [Exercise]) -> [ExerciseMO]
    func readData() -> [ExerciseMO]
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
    
    func saveData(exercises: [Exercise]) -> [ExerciseMO] {
        var exercisesMO = [ExerciseMO]()
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
        
        exercises.forEach { (ex) in
            guard let exerciseMO = NSManagedObject(entity: entity, insertInto: managedContext) as? ExerciseMO else { fatalError() }
            exerciseMO.copyValue(from: ex)
            exercisesMO.append(exerciseMO)
        }
        do {
            try managedContext.save()
        } catch let error {
            print(error)
        }
        return exercisesMO
        
    }
    
    func readData() -> [ExerciseMO] {
        var exercisesMO = [ExerciseMO]()
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        
        do {
           exercisesMO = try managedContext.fetch(fetchRequest) as! [ExerciseMO]
        } catch let error as NSError {
            print(error)
        }
        return exercisesMO
    }
    
    func clearData() {
        let managedContext = persistentContainer.viewContext
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
            guard let exercisesMO = try (managedContext.fetch(fetchRequest)) as? [ExerciseMO] else { return }
            
            for exercise in exercisesMO {
                managedContext.delete(exercise)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
