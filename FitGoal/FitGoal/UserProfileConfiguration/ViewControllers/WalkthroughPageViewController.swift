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
    private var currentIndex = Int() {
        didSet {
            if currentIndex == (walkthroughViewControllers.count - 1) {
                nextViewControllerButton.isHidden = true
            } else {
                nextViewControllerButton.isHidden = false
            }
        }
    }
    
    private let defaultBottomMargin = CGFloat(-30)
    
    private lazy var bottomConstraint = nextViewControllerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    
    private var bottomConstant = CGFloat() {
        didSet {
            bottomConstraint.constant = bottomConstant
            bottomConstraint.isActive = true
        }
    }
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -130, y: -250)
        return gradientView
    }()
    
    private let viewTitleLabel = UILabel()
    
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
            userInfoEntryView: ListIconView(iconList:[
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .male)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .female))
            ]),
            questionPrefix: "What is",
            questionSuffix: "your gender".uppercased(),
            userProfileType: .gender
        )

        let fitnessLevel = UserProfileConfiguratorViewController(
            userInfoEntryView: ListIconView(iconList:[
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .skinny)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .normal)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .obese)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .athletic))
            ]),
            questionPrefix: "What is your current fitness",
            questionSuffix: "level".uppercased(),
            userProfileType: .fitnessLevel
        )

        let fitnessGoal = UserProfileConfiguratorViewController(
            userInfoEntryView: ListIconView(iconList:[
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .skinny)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .normal)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .obese)),
                WalkthroughIconView(icon: WalkthroughIcon(iconType: .athletic))
            ]),
            questionPrefix: "What is",
            questionSuffix: "your goal".uppercased(),
            userProfileType: .fitnessGoal
        )
        
        let age = UserProfileConfiguratorViewController(
            userInfoEntryView: getTextField(),
            questionPrefix: "What is",
            questionSuffix: "your age".uppercased(),
            userProfileType: .age
        )
        
        let height = UserProfileConfiguratorViewController(
            userInfoEntryView: getTextField(),
            questionPrefix: "What is",
            questionSuffix: "your height".uppercased(),
            userProfileType: .height
        )
        
        let weight = UserProfileConfiguratorViewController(
            userInfoEntryView: getTextField(),
            questionPrefix: "What is",
            questionSuffix: "your weight".uppercased(),
            userProfileType: .weight
        )
        
        let planning = UserPlanningViewController()
        
        return [gender, fitnessLevel, fitnessGoal, age, height, weight, planning]
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
            viewTitleLabel,
            nextViewControllerButton,
            pageControl
        ]
        self.view.addMultipleSubviews(views)
        
        self.setViewControllers([walkthroughViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
        changeTitle(forLabel: viewTitleLabel, vcIndex: currentIndex)
        
        setConstraints()
        
        nextViewControllerButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func nextViewController() {
        if (currentIndex + 1) < walkthroughViewControllers.count {
            currentIndex += 1
            pageControl.currentPage = currentIndex
            self.setViewControllers([walkthroughViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
            changeTitle(forLabel: viewTitleLabel, vcIndex: currentIndex)
        }
    }
    
    private func changeTitle(forLabel label: UILabel, vcIndex index: Int) {
        if walkthroughViewControllers[index] is UserPlanningViewController {
             label.attributedText = "Planing".uppercased().formattedText(font: "Oswald-Medium", size: 18, color: .white, kern: 0.50)
        } else if walkthroughViewControllers[index] is UserProfileConfiguratorViewController {
            label.attributedText = "Create your profile".uppercased().formattedText(font: "Oswald-Medium", size: 18, color: .white, kern: 0.50)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        bottomConstant = -keyboardSize.height
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomConstant = defaultBottomMargin
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func getTextField() -> UITextField {
        let texField = UITextField()
        texField.backgroundColor = .white
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
        viewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            viewTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        ])
    }
    
    private func setButtonConstraints() {
        nextViewControllerButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstant = defaultBottomMargin
        NSLayoutConstraint.activate([
            nextViewControllerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            nextViewControllerButton.heightAnchor.constraint(equalToConstant: 72),
            nextViewControllerButton.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    private func setPageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            pageControl.topAnchor.constraint(equalTo: viewTitleLabel.topAnchor)
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
            changeTitle(forLabel: viewTitleLabel, vcIndex: currentIndex)
        }
    }
}
