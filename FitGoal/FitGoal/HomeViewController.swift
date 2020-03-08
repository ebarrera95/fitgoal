//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

var imageCache: [URL: UIImage] = [:]

class HomeViewController: UIViewController {

    let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var workoutSuggestions = [Routine]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)

        self.view.addSubview(homeCollectionView)
        //homeCollectionView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0)

        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self

        self.homeCollectionView.register(
            SuggestedRoutineCell.self,
            forCellWithReuseIdentifier: SuggestedRoutineCell.indentifier
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
        

        self.homeCollectionView.alwaysBounceVertical = true
        self.homeCollectionView.backgroundColor = .none

        fetchRoutines { result in
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeCollectionView.frame = view.bounds
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
    func fetchRoutines(completion: @escaping (Result<[Routine], Error>) -> Void) {
        let jsonUrlString = "https://my-json-server.typicode.com/rlaguilar/fitgoal/routines"
        guard let url = URL(string: jsonUrlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                guard let error = error else {
                    assertionFailure("Error shouldn't be nil when there is no data")
                    return
                }
                
                completion(.failure(error))
                return
            }
            
            do {
                let routines = try JSONDecoder().decode([Routine].self, from: data)
                completion(.success(routines))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
