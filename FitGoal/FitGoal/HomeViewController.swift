//
//  ViewController.swift
//  FitGoal
//
//  Created by Reynaldo Aguilar on 2/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

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
    var workoutSuggestions: [Routine] = [
        Routine(name: "HOME WOROUT", url: "https://i.ibb.co/0K0MxzZ/home-gym.jpg", excercices: [3, 7, 14, 15]),
        Routine(name: "HOME WOROUT", url: "https://i.ibb.co/0K0MxzZ/home-gym.jpg", excercices: [3, 7, 14, 15]),
        Routine(name: "HOME WOROUT", url: "https://i.ibb.co/0K0MxzZ/home-gym.jpg", excercices: [3, 7, 14, 15])]
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(topView)
        layoutCollectionView()
        
        self.suggestionCollectionView.dataSource = self
        self.suggestionCollectionView.delegate = self
        
        self.suggestionCollectionView.register(SuggestedRoutineCell.self, forCellWithReuseIdentifier: SuggestedRoutineCell.indentifier)
        self.suggestionCollectionView.alwaysBounceVertical = true
        self.suggestionCollectionView.backgroundColor = .none
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
