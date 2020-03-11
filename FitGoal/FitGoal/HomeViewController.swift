//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

var imageCache: [URL: UIImage] = [:]

class HomeViewController: UIViewController, RoutineDelegate {
    
    var allExercises = [Exercise]()

    var inspectorState = RoutineInspectorState.unset
    
    var routineCellDelegate: RoutineDelegate?
    
    private var gradientView: UIView = {
        let gradientView = GradientView()
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.03921568627, green: 0, blue: 0, alpha: 0.27), #colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0)]
        return gradientView
    }()

    let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var workoutSuggestions = [Routine]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(homeCollectionView)
        self.view.addSubview(gradientView)
        
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeCollectionView.frame = view.bounds
        gradientView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
    }
    
    func displayExercises(routine: Routine) {
        inspectorState = .inspecting(routine)
        homeCollectionView.performBatchUpdates({
            homeCollectionView.reloadSections([1])
        }, completion: nil)
    }
}

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    var colors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
}

extension HomeViewController {
    func fetchWorkoutRoutines() {
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

    enum RoutineInspectorState {
        case inspecting(Routine)
        case unset

        var didUserSelectRoutine: Bool {
            switch self {
            case .unset:
                return false
            case .inspecting:
                return true
            }
        }
    }
}

extension HomeViewController {
    func fetchExercises() {
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
