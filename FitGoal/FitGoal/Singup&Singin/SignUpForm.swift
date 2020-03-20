//
//  SingUpForm.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SignUpForm: UIStackView {
    
    let name = CustomTextField(placeholder: "Name")
    let emailAddress = CustomTextField(placeholder: "Email")
    let pasword = CustomTextField(placeholder: "Password")
    let confirmPasword = CustomTextField(placeholder: "Confirm Password")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .leading
        spacing = 64
        backgroundColor = .cyan
        
        addArrangedSubview(name)
        addArrangedSubview(emailAddress)
        addArrangedSubview(pasword)
        addArrangedSubview(confirmPasword)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let fieldSize = CGSize(width: superview!.bounds.width - 64, height: 64)
        name.frame.size = fieldSize
        emailAddress.frame.size = fieldSize
        pasword.frame.size = fieldSize
        confirmPasword.frame.size = fieldSize
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomTextField: UITextField {
    
    let buttonLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return line
    }()
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.attributedPlaceholder = placeholder.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(buttonLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonLine.frame = CGRect(x: 0, y: self.bounds.maxY, width: self.bounds.width, height: 1)
    }
}
