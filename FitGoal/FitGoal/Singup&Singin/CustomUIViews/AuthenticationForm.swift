//
//  SingUpForm.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AuthenticationForm: UIStackView, UITextFieldDelegate {
    
    weak var customTextFieldDelegate: CustomTextFieldDelegate?

    private let name: CustomTextField = {
        let name = CustomTextField(placeholder: "Name")
        name.textContentType = .name
        name.returnKeyType = .next
        name.tag = 0
        return name
    }()
    
    private let emailAddress: CustomTextField = {
        let email = CustomTextField(placeholder: "Email")
        email.textContentType = .emailAddress
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.returnKeyType = .next
        email.tag = 1
        return email
    }()
    
    private let password: CustomTextField = {
        let password = CustomTextField(placeholder: "Password")
        password.textContentType = .password
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.returnKeyType = .next
        password.tag = 2
        return password
    }()
    
    private let confirmPasword: CustomTextField = {
        let password = CustomTextField(placeholder: "Confirm Password")
        password.textContentType = .password
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.returnKeyType  = .done
        password.tag = 3
        return password
    }()
    
    convenience init(authenticationType: AuthenticationType) {
        self.init(frame: .zero)
        
        switch authenticationType {
        case .login:
            addArrangedSubview(emailAddress)
            addArrangedSubview(password)
            
            password.returnKeyType = .done
        case .signUp:
            addArrangedSubview(name)
            addArrangedSubview(emailAddress)
            addArrangedSubview(password)
            addArrangedSubview(confirmPasword)
        case .none:
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .leading
        spacing = 64
        
        name.delegate = self
        emailAddress.delegate = self
        password.delegate = self
        confirmPasword.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let fieldSize = CGSize(width: self.bounds.width, height: 54)
        name.frame.size = fieldSize
        emailAddress.frame.size = fieldSize
        password.frame.size = fieldSize
        confirmPasword.frame.size = fieldSize
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func userDidHitReturnKey(in textField: UITextField) {
        if textField.returnKeyType == .next {
            guard let textFieldIndex = self.subviews.firstIndex(of: textField) else { return }
            textField.resignFirstResponder()
            let nextTextField = self.subviews[textFieldIndex + 1]
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDidHitReturnKey(in: textField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == confirmPasword {
            customTextFieldDelegate?.showTextField()
        }
    }
}

protocol CustomTextFieldDelegate: AnyObject {
    func showTextField()
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

enum AuthenticationType {
    case signUp
    case login
    case none
}

//private enum TextFieldTag: Int {
//    case nameField
//    case emailField
//    case PasswordField
//    case ConfirmPasswordField
//}
