//
//  RoutinesCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit



class ExploreRoutineCell: UICollectionViewCell {
    
    var routine: Routine?
    
    private var routineExercies = [Exercise]()
    
    private let routineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    static let identifier = "Routines Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(routineCollectionView)
        
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
        routineCollectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        
        let layout = routineCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
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
    
    func reloadCellData(exercises: [Exercise]) {
        if let routine = self.routine {
                routineExercies = exercises.filter({ (exersice) -> Bool in
                return routine.exercises.contains(exersice.id)
            })
            routineCollectionView.reloadData()
        }
    }
}

extension ExploreRoutineCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineExercies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell Exercise", for: indexPath) as! ExerciseCell
        cell.exercise = routineExercies[indexPath.item]
        return cell
    }
}

extension ExploreRoutineCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
