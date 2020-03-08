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
    lazy var topView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 600, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 10, y: -600)
        return gradientView
    }()

    let suggestionsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var workoutSuggestions = [Routine]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(topView)
        self.view.addSubview(suggestionsCollectionView)

        self.suggestionsCollectionView.dataSource = self
        self.suggestionsCollectionView.delegate = self

        self.suggestionsCollectionView.register(
            SuggestedRoutineCell.self,
            forCellWithReuseIdentifier: SuggestedRoutineCell.indentifier
        )
        
        self.suggestionsCollectionView.register(
            RoutineSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RoutineSectionHeader.identifier
        )
        self.suggestionsCollectionView.register(
            GoalTrakerCell.self,
            forCellWithReuseIdentifier: GoalTrakerCell.identifier
        )
        

        self.suggestionsCollectionView.alwaysBounceVertical = true
        self.suggestionsCollectionView.backgroundColor = .none

        fetchRoutines { result in
            switch result {
            case .failure(let error):
                print("Unable to get routines with error: \(error)")
            case .success(let routines):
                DispatchQueue.main.async {
                    self.workoutSuggestions = routines
                    self.suggestionsCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        suggestionsCollectionView.frame = view.bounds
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
