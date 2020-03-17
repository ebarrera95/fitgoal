//
//  RoutinesCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol RoutineInspectorCellDelegate: AnyObject {
    func userDidSelectExersice(_ exercise: Exercise)
}

class RoutineInspectorCell: UICollectionViewCell {
    
    weak var routineInspectorCellDelegate: RoutineInspectorCellDelegate?
    
    private var routineExercises = [Exercise]()
    
    private let routineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    static let identifier = "Routines Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(routineCollectionView)
        routineCollectionView.backgroundColor = .clear
        
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
        routineCollectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        routineCollectionView.isUserInteractionEnabled = true
        
        let layout = routineCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        switch sender.state {
        case .ended:
            let tapLocation = sender.location(in: routineCollectionView)
            guard let indexPath = routineCollectionView.indexPathForItem(at: tapLocation) else { return }
            guard let cell = routineCollectionView.cellForItem(at: indexPath) as? ExerciseCell else { return }
            guard let exercise = cell.exercise else { return }
            routineInspectorCellDelegate?.userDidSelectExersice(exercise)
        default:
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        routineCollectionView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func display(exercises: [Exercise]) {
        var exercises = exercises
        exercises.sort { (ex1, ex2) -> Bool in
            ex1.id < ex2.id
        }
        routineExercises = exercises
        routineCollectionView.reloadData()
    }
}

extension RoutineInspectorCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineExercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
        cell.exercise = routineExercises[indexPath.item]
        return cell
    }
}

extension RoutineInspectorCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
