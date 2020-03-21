//
//  LoginLinkStack.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol HandleLinkTap {
    func userDidSelectLink()
}

class AutenticationLink: UIStackView {
    
    private var question = UILabel()
    
    private var link = UIButton(type: .system)
    
   var linkDelegate: HandleLinkTap?
    
    convenience init(autenticationType: AutenticationType) {
        self.init(frame: .zero)
        var questionText = String()
        var linkText = String()
        switch autenticationType {
        case .login:
            questionText =  "Don't have an account?"
            linkText = "Signup"
        case .signUp:
            questionText = "Already onboard?"
            linkText = "Login"
        }
        
        question.attributedText = questionText.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
        link.setAttributedTitle(linkText.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
            kern: 0
        ), for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        link.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        print("tap!")
        switch sender.state {
        case .ended:
            linkDelegate?.userDidSelectLink()
            print("tap ended")
        default:
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        alignment = .center
        spacing = 8
        
        addArrangedSubview(question)
        addArrangedSubview(link)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
