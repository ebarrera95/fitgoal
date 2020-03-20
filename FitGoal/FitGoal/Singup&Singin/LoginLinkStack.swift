//
//  LoginLinkStack.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class LoginLinkStack: UIStackView {
    
    private var question = UILabel()
    
    private var link = UIButton()
    
    convenience init(questionText: String, linkText: String){
        self.init(frame: .zero)
        
        let questionText = questionText.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
        let linkText = linkText.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.24, green: 0.78, blue: 0.9, alpha: 1),
            kern: 0
        )
        
        question.attributedText = questionText
        link.setAttributedTitle(linkText, for: .normal)
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
