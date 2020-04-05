//
//  AuthenticationViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 3/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    private var authenticator: SocialMediaAuthenticator
    
    private var blurEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .extraLight)
        blurEffectView.effect = blurEffect
        return blurEffectView
    }()
    
    init(socialMedia: SocialMedia) {
        self.authenticator = SocialMediaAuthenticator(socialMedia: socialMedia)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func login() {
        loginStatus = .attempting
        authenticator.authenticate(sender: self) { result in
            switch result {
            case .success:
                self.loginStatus = .loggedIn
            case .failure(let error):
                self.loginStatus = .failed(error)
            }
        }
    }
    
    private let placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .large
        return placeholder
    }()
    
    private var loginStatus: LoginStatus? {
        didSet {
            DispatchQueue.main.async {
                switch self.loginStatus {
                case .loggedIn:
                    let vc = HomeViewController(persistance: CoreDataPersistance())
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true)
                case .attempting:
                    self.view.addSubview(self.placeholder)
                    self.placeholder.center = self.view.center
                    self.placeholder.startAnimating()
                case.failed(let error):
                    print("Unable to login, reason: \(error)")
                    self.dismiss(animated: true, completion: nil)
                case.none:
                    return
                }
            }
        }
    }
    
    private var viewDidAppearOnce = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurEffectView)
        view.backgroundColor = .clear
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewDidAppearOnce {
            login()
        }
        viewDidAppearOnce = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurEffectView.frame = view.bounds
        placeholder.center = view.center
    }
}

private enum LoginStatus {
    case attempting
    case loggedIn
    case failed(Error)
}
