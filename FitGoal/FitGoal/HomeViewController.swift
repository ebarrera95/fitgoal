//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

var imageCache: [URL:UIImage] = [:]
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
    
    weak var suggestionCollectionView: UICollectionView!
    
    var workoutSuggestions = [Routine]()
    
    var imageCache: [URL:UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(topView)
        layoutCollectionView()
        
        self.suggestionCollectionView.dataSource = self
        self.suggestionCollectionView.delegate = self
        
        self.suggestionCollectionView.register(SuggestedRoutineCell.self, forCellWithReuseIdentifier: SuggestedRoutineCell.indentifier)
        self.suggestionCollectionView.register(RoutineSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RoutineCellHeader")
        
        self.suggestionCollectionView.alwaysBounceVertical = true
        self.suggestionCollectionView.backgroundColor = .none
        
        fetchRoutinesFormJSON { (routines, error) in
            if let routines = routines {
                DispatchQueue.main.async {
                    self.workoutSuggestions = routines
                    self.suggestionCollectionView.reloadData()
                }
            }
        }
    }
    
    private func layoutCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.suggestionCollectionView = collectionView
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
    func fetchRoutinesFormJSON(completion: @escaping ([Routine]?, Error?) -> Void) {
        let jsonUrlString = "https://my-json-server.typicode.com/rlaguilar/fitgoal/routines"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else { return}
            do {
                let routines = try JSONDecoder().decode([Routine].self, from: data)
                completion(routines, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
