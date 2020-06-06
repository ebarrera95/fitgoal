//
//  RoutinePlayerPageViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 13/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class RoutinePlayerPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    private var currentIndex = 0
    
    private let firstExercise: Exercise
    private let routine: [Exercise]
    
    private var exercisePlayerViewControllers: [UIViewController] = []
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle("stop".uppercased().formattedText(font: "Roboto-Light", size: 15, color: .white, kern: 0.18), for: .normal)
        return button
    }()
    
    init(firstExercise: Exercise, exercises: [Exercise]) {
        self.firstExercise = firstExercise
        self.routine = exercises
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getInitialIndex(of exercise: Exercise, in exercises: [Exercise] ) -> Int  {
        for index in exercises.indices {
            if exercises[index] == exercise {
                return index
            }
        }
        return 0
    }
    
    private func getViewControllers(for exercises: [Exercise]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        for index in exercises.indices {
            viewControllers.append(ExercisePlayerViewController(exercise: exercises[index]))
        }
        return viewControllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(BackgroundGradientView(frame: view.bounds), at: 0)
        view.addSubview(stopButton)
        
        setStopButtonConstraints()
        exercisePlayerViewControllers = getViewControllers(for: self.routine)
        self.delegate = self
        self.dataSource = self
        
        currentIndex = getInitialIndex(of: firstExercise, in: routine)
        self.setViewControllers(
            [exercisePlayerViewControllers[currentIndex]],
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
