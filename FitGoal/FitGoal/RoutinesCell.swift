//
//  RoutinesCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class RoutinesCell: UICollectionViewCell {
    
    var routines = [Exercise]()
    
    var routineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    static var identifier = "Routines Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
        let layout = routineCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        routineCollectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        self.addSubview(routineCollectionView)
        fetchExersices()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        routineCollectionView.frame = self.bounds
        routineCollectionView.backgroundColor = .none
    }
}

extension RoutinesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell Exercise", for: indexPath) as! ExerciseCell
        cell.exercise = routines[indexPath.item]
        return cell
    }
}

extension RoutinesCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension RoutinesCell {
    func fetchExersices() {
        let jsonUrlString = "https://my-json-server.typicode.com/rlaguilar/fitgoal/exercices"
        guard let url = URL(string: jsonUrlString) else { return }
        url.fetch { (result: Result<[Exercise], Error>) in
            switch result {
            case .failure(let error):
                print("Unable to get routines with error: \(error)")
            case .success(let routines):
                DispatchQueue.main.async {
                    self.routines = routines
                    self.routineCollectionView.reloadData()
                }
            }
        }
    }
}

