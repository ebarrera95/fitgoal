//
//  UserProfilePageViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserProfilePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -130, y: -250)
        return gradientView
    }()
    
    private var userProfileViewControllers: [UIViewController] = [
        UserLevelViewController(),
        UserGenderViewController()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.insertSubview(gradientBackgroundView, at: 0)
        self.setViewControllers([userProfileViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
}

extension UserProfilePageViewController {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = userProfileViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        
        if previousIndex >= 0, userProfileViewControllers.count >= previousIndex {
            return userProfileViewControllers[previousIndex]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = userProfileViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        
        if userProfileViewControllers.count != nextIndex, userProfileViewControllers.count > nextIndex {
            return userProfileViewControllers[nextIndex]
        } else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return userProfileViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstVCIndex = userProfileViewControllers.firstIndex(of: firstVC) else { return 0 }
        return firstVCIndex
    }
    
}
