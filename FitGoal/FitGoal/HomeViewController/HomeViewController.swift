//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var routineState  = RoutineStateInspector.unset
    
    private var persitence: Persistence
    
    private var allExercises = [Exercise]()

    private let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var workoutSuggestions = [Routine]()
    
    private var statusBarGradient: UIView = {
        let gradientView = GradientView()
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.03921568627, green: 0, blue: 0, alpha: 0.27), #colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0)]
        return gradientView
    }()
    
    init(persistance: Persistence) {
        self.persitence = persistance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(homeCollectionView)
        self.view.addSubview(statusBarGradient)
        
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self

        self.homeCollectionView.register(
            SuggestedRoutineCell.self,
            forCellWithReuseIdentifier: SuggestedRoutineCell.identifier
        )
        
        self.homeCollectionView.register(
            RoutineSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RoutineSectionHeader.identifier
        )
        
        self.homeCollectionView.register(
            GoalTrakerCell.self,
            forCellWithReuseIdentifier: GoalTrakerCell.identifier
        )
        
        self.homeCollectionView.register(
            RoutineInspectorCell.self,
            forCellWithReuseIdentifier: RoutineInspectorCell.identifier
        )
        
        self.homeCollectionView.alwaysBounceVertical = true
        self.homeCollectionView.backgroundColor = .clear
        
        fetchWorkoutRoutines()
        fetchExercises()
        
        readLastSeenRoutine()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeCollectionView.frame = view.bounds
        statusBarGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
    }
    
    func readLastSeenRoutine() {
        let exercises = persitence.readExercises()
        if !exercises.isEmpty {
            routineState = .inspecting(exercises)
        }
    }
}

extension HomeViewController: SuggestedRoutineCellDelegate {
    func userDidSelectRoutine(_ routine: Routine) {
        let routineExercises = allExercises.filter { routine.exercises.contains($0.id) }
        
        persitence.clearData()
        persitence.save(exercises: routineExercises)
        routineState = .inspecting(routineExercises)
        homeCollectionView.performBatchUpdates({
            homeCollectionView.reloadSections([1])
        }, completion: nil)
    }
    
}

extension HomeViewController {
    private func fetchWorkoutRoutines() {
        let jsonUrlString = "https://my-json-server.typicode.com/rlaguilar/fitgoal/routines"
        guard let url = URL(string: jsonUrlString) else { return }
        url.fetch { (result: Result<[Routine], Error>) in
            switch result {
            case .failure(let error):
                print("Unable to get routines with error: \(error)")
            case .success(let routines):
                DispatchQueue.main.async {
                    self.workoutSuggestions = routines
                    self.homeCollectionView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController {
    private func fetchExercises() {
        let jsonUrlString = "https://my-json-server.typicode.com/rlaguilar/fitgoal/exercices"
        guard let url = URL(string: jsonUrlString) else { return }
        url.fetch { (result: Result<[Exercise], Error>) in
            switch result {
            case .failure(let error):
                print("Unable to get routines with error: \(error)")
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.allExercises = exercise
                }
            }
        }
    }
}

extension HomeViewController: RoutineInspectorCellDelegate {
    func userDidSelectExercise(_ exercise: Exercise) {
        switch routineState {
        case .unset:
            return
        case .inspecting(let exercises):
            let orderedExercises = exercises.sorted { (ex1, ex2) -> Bool in
                return ex1.id < ex2.id
            }
            let vc = DetailViewController(exercise: exercise, exercises: orderedExercises)
            show(vc, sender: self.homeCollectionView)
        }
    }
}
