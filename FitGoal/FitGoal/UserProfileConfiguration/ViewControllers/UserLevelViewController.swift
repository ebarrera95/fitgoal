//
//  UserLevelViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 22/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserLevelViewController: UIViewController {
    
    private var bodyLevelChooserView = BodyLevelView()
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: -130, y: -250)
        return gradientView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(gradientBackgroundView)
        view.addSubview(bodyLevelChooserView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bodyLevelChooserView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        bodyLevelChooserView.center = view.center
    }
}

private class BodyLevelView: UIView {
    let skinnyBody = IconBuilderView(icon: BodyShape(shape: .skinny))
    let normalBody = IconBuilderView(icon: BodyShape(shape: .normal))
    let obeseBody = IconBuilderView(icon: BodyShape(shape: .obese))
    let athleticBody = IconBuilderView(icon: BodyShape(shape: .athletic))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [
            skinnyBody,
            normalBody,
            obeseBody,
            athleticBody
        ]
        addMultipleSubviews(views)
        setConstraints()
        setIconsSize(icons: views)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        setSkinnyBodyConstraints()
        setNormalBodyConstraints()
        setAthleticBodyConstraints()
        setObeseBodyConstraints()
    }
    //TODO: Rename func
    private func setIconsSize(icons: [UIView]) {
        icons.forEach { (view) in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 152),
                view.widthAnchor.constraint(equalToConstant: 152)
            ])
        }
    }
    
    private func setSkinnyBodyConstraints() {
        skinnyBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinnyBody.topAnchor.constraint(equalTo: self.topAnchor),
            skinnyBody.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setNormalBodyConstraints() {
        normalBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            normalBody.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            normalBody.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setObeseBodyConstraints() {
        obeseBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            obeseBody.topAnchor.constraint(equalTo: self.topAnchor),
            obeseBody.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setAthleticBodyConstraints() {
        athleticBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            athleticBody.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            athleticBody.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
