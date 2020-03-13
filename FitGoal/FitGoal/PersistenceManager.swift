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
    func save(exercise: Exercise)
    func read()
    func clearData()
}

class PersistenceManager: Persistence {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FitGoal")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var exercisesMO = [ExerciseMO]()
    
    var routineState = RoutineStateInspector.unset
    
    func fetchLastRoutine() {
        read()
        if !exercisesMO.isEmpty {
            var exercises = [Exercise]()
            exercisesMO.forEach { (exMO) in
                exercises.append(exMO.exercise())
            }
            routineState = .inspecting(exercises)
        }
    }
    
    func save(exercise: Exercise) {
        let managedContext = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
        guard let exerciseMO = NSManagedObject(entity: entity, insertInto: managedContext) as? ExerciseMO else { return }
        exerciseMO.copyValues(from: exercise)
        
        do {
            try managedContext.save()
            exercisesMO.append(exerciseMO)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func read() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        
        do {
            self.exercisesMO = try managedContext.fetch(fetchRequest) as! [ExerciseMO]
        } catch let error as NSError {
            print(error)
        }
    }
    
    func clearData() {
        let managedContext = persistentContainer.viewContext
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
            let exercises = try (managedContext.fetch(fetchRequest)) as? [ExerciseMO]
            
            for exercise in exercises! {
                managedContext.delete(exercise)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
