//
//  RoutinePlayerPageViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class RoutinePlayerPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    private let routine: [Exercise]
    private let firstExerciseIndex: Int
    
    private var exercisePlayerViewControllers: [UIViewController] = []
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle("stop".uppercased().formattedText(font: "Roboto-Light", size: 15, color: .white, kern: 0.18), for: .normal)
        return button
    }()
    
    init(firstExerciseIndex: Int, routine: [Exercise]) {
        self.firstExerciseIndex = firstExerciseIndex
        self.routine = routine
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getViewControllers(for exercises: [Exercise]) -> [UIViewController] {
        return exercises.map { ExercisePlayerViewController(exercise: $0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(ExercisePlayerBackgroundView(frame: view.bounds), at: 0)
        view.addSubview(stopButton)
        
        setStopButtonConstraints()
        exercisePlayerViewControllers = getViewControllers(for: self.routine)
        self.delegate = self
        self.dataSource = self
        
        self.setViewControllers(
            [exercisePlayerViewControllers[self.firstExerciseIndex]],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = exercisePlayerViewControllers.firstIndex(of: viewController) else { return nil }
        guard !(currentIndex == 0) else { return nil }
        let previousIndex = currentIndex - 1
        return exercisePlayerViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = exercisePlayerViewControllers.firstIndex(of: viewController) else { return nil }
        guard !(currentIndex == exercisePlayerViewControllers.count - 1) else { return nil }
        let nextIndex = currentIndex + 1
        return exercisePlayerViewControllers[nextIndex]
    }
    
    private func setStopButtonConstraints() {
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54)
        ])
    }
}
