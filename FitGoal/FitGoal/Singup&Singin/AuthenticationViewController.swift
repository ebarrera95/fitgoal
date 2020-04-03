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
    
    init(socialMedia: SocialMedia) {
        self.authenticator = SocialMediaAuthenticator(socialMediaType: socialMedia)
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
        placeholder.color = .white
        placeholder.style = .large
        return placeholder
    }()
    
    private var loginStatus = LoginStatus.loggedOut {
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
                    let vc = GreetingViewController()
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                    print("Unable to login, reason: \(error)")
                case.loggedOut:
                    return
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.5)
        view.isOpaque = false
        view.alpha = 0.5
        login()
        print("viewDidLoad end")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placeholder.center = view.center
    }
}

enum LoginStatus {
    case loggedOut
    case attempting
    case loggedIn
    case failed(Error)
}
