//
//  UserProfilePageViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pendingIndex = Int()
    private var currentIndex = Int()
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -130, y: -250)
        return gradientView
    }()
    
    private let createYourProfileLabel: UILabel = {
        let label = UILabel()
        let title = "Create your Profile".uppercased()
        label.attributedText = title.formattedText(font: "Oswald-Medium", size: 18, color: .white, kern: 0.50)
        return label
    }()
    
    private let nextViewControllerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "next"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2884573063)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 1
        return button
    }()
    
    private lazy var walkthroughViewControllers: [UIViewController] = {
        let gender = UserProfileConfiguratorViewController(
            selectorView: GenderView(),
            questionPrefix: "What is",
            questionSuffix: "your gender".uppercased()
        )
        
        let fitnessLevel = UserProfileConfiguratorViewController(
            selectorView: FitnessLevelChooserView(),
            questionPrefix: "What is your current fitness",
            questionSuffix: "level".uppercased()
        )
        
        let fitnessGoal = UserProfileConfiguratorViewController(
            selectorView: FitnessLevelChooserView(),
            questionPrefix: "What is",
            questionSuffix: "your goal".uppercased()
        )
        
        let age = UserProfileConfiguratorViewController(
            selectorView: getTextField(),
            questionPrefix: "What is",
            questionSuffix: "your age".uppercased()
        )
        
        let height = UserProfileConfiguratorViewController(
            selectorView: getTextField(),
            questionPrefix: "What is",
            questionSuffix: "your height".uppercased()
        )
        
        let weight = UserProfileConfiguratorViewController(
            selectorView: getTextField(),
            questionPrefix: "What is",
            questionSuffix: "your weight".uppercased()
        )
        
        return [gender, fitnessLevel, fitnessGoal, age, height, weight]
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = walkthroughViewControllers.count
        pageControl.currentPage = currentIndex
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2431372549, green: 0.7803921569, blue: 0.9019607843, alpha: 1)
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.insertSubview(gradientBackgroundView, at: 0)
        
        let views = [
            createYourProfileLabel,
            nextViewControllerButton,
            pageControl
        ]
        
        self.view.addMultipleSubviews(views)
        
        self.setViewControllers([walkthroughViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
        setConstraints()
        
        nextViewControllerButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
    }
    
    @objc private func nextViewController() {
        if (currentIndex + 1) < walkthroughViewControllers.count {
            currentIndex += 1
            pageControl.currentPage = currentIndex
            self.setViewControllers([walkthroughViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func getTextField() -> UITextField {
        let texField = UITextField()
        texField.backgroundColor = .white
        texField.layer.cornerRadius = 7
        texField.layer.shadowOffset = CGSize(width: 0, height: 6)
        texField.layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        texField.layer.shadowOpacity = 1
        texField.layer.shadowRadius = 10
        texField.layer.cornerRadius = 7
        texField.keyboardType = .asciiCapableNumberPad
        texField.textColor = #colorLiteral(red: 0.5215686275, green: 0.5333333333, blue: 0.568627451, alpha: 1)
        texField.font = UIFont(name: "Oswald-Medium", size: 50)
        texField.textAlignment = .center
        return texField
    }
    
    private func setConstraints() {
        setLabelConstraints()
        setButtonConstraints()
        setPageControlConstraints()
    }
    
    private func setLabelConstraints() {
        createYourProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createYourProfileLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            createYourProfileLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50)
        ])
    }
    
    private func setButtonConstraints() {
        nextViewControllerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextViewControllerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            nextViewControllerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            nextViewControllerButton.heightAnchor.constraint(equalToConstant: 72),
            nextViewControllerButton.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    private func setPageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            pageControl.topAnchor.constraint(equalTo: createYourProfileLabel.topAnchor)
        ])
    }
}

extension WalkthroughPageViewController {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = walkthroughViewControllers.firstIndex(of: viewController) else { return nil }
        guard !(currentIndex == 0) else { return nil }
        let previousIndex = currentIndex - 1
        return walkthroughViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = walkthroughViewControllers.firstIndex(of: viewController) else { return nil }
        guard !(currentIndex == walkthroughViewControllers.count - 1) else { return nil }
        let nextIndex = currentIndex + 1
        return walkthroughViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first else { return }
        guard let index = walkthroughViewControllers.firstIndex(of: vc) else { return }
        pendingIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            pageControl.currentPage = currentIndex
        }
    }
}
