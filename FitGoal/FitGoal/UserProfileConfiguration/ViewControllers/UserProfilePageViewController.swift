//
//  UserProfilePageViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 26/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserProfilePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
    
    private var questionPrefix = UILabel()
    private var questionSuffix = UILabel()
    
    private let nextViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "next"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2884573063)
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 1
        return button
    }()
    
    private lazy var userProfileViewControllers: [UIViewController] = [
        UserLevelViewController(),
        UserGenderViewController()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.insertSubview(gradientBackgroundView, at: 0)
        
        let views = [
            createYourProfileLabel,
            questionSuffix,
            questionPrefix,
            nextViewButton
        ]
        self.view.addMultipleSubviews(views)
        
        self.setViewControllers([userProfileViewControllers[0]], direction: .forward, animated: true, completion: nil)
        if let viewController = viewControllers?.first as? UserLevelViewController {
            self.questionPrefix.attributedText = getQuestionPrefix(text: viewController.questionPrefix)
            self.questionSuffix.attributedText = getQuestionSuffix(text: viewController.questionSuffix)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        setLabelConstraints()
        setQuestionPrefixLabelConstraints()
        setQuestionSuffixLabelConstraints()
        setButtonConstraints()
    }
    
    private func getQuestionPrefix(text: String) -> NSAttributedString {
        return text.formattedText(font: "Roboto-Light", size: 19, color: .white, kern: 0.23)
    }
    
    private func getQuestionSuffix(text: String) -> NSAttributedString {
        return text.formattedText(font: "Oswald-Medium", size: 49, color: .white, kern: 0.59)
    }
 
    private func setLabelConstraints() {
        createYourProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createYourProfileLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            createYourProfileLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }
    
    private func setQuestionPrefixLabelConstraints() {
        questionPrefix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionPrefix.topAnchor.constraint(equalTo: self.createYourProfileLabel.bottomAnchor, constant: 40),
            questionPrefix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }
    
    private func setQuestionSuffixLabelConstraints() {
        questionSuffix.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionSuffix.topAnchor.constraint(equalTo: self.questionPrefix.bottomAnchor, constant: 16),
            questionSuffix.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58)
        ])
    }
    
    private func setButtonConstraints() {
        nextViewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextViewButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            nextViewButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            nextViewButton.heightAnchor.constraint(equalToConstant: 72),
            nextViewButton.widthAnchor.constraint(equalToConstant: 72)
        ])
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

extension UserProfilePageViewController {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let viewController = viewControllers?.first as? UserLevelViewController {
                self.questionPrefix.attributedText = getQuestionPrefix(text: viewController.questionPrefix)
                self.questionSuffix.attributedText = getQuestionSuffix(text: viewController.questionSuffix)
                return
            }
            
            if let viewController = viewControllers?.first as? UserGenderViewController {
                self.questionPrefix.attributedText = getQuestionPrefix(text: viewController.questionPrefix)
                self.questionSuffix.attributedText = getQuestionSuffix(text: viewController.questionSuffix)
                return
            }
        }
    }
}
