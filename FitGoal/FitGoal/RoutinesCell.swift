//
//  RoutinesCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit



class RoutinesCell: UICollectionViewCell {
    
    var routine: Routine?
    
    func reloadCellData(exercises: [Exercise]) {
        if let routine = self.routine {
                routineExercies = exercises.filter({ (exersice) -> Bool in
                return routine.exercises.contains(exersice.id)
            })
            routineCollectionView.reloadData()
        }
    }
    
    var routineExercies = [Exercise]()
    
    var exercisesDelegate: RoutineDelegate?
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        routineCollectionView.frame = self.bounds
        routineCollectionView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension RoutinesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineExercies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell Exercise", for: indexPath) as! ExerciseCell
        cell.exercise = routineExercies[indexPath.item]
        return cell
    }
}

extension RoutinesCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 215)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

