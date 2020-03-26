//
//  SingUpForm.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class AuthenticationFormStack: UIStackView, UITextFieldDelegate {
    
    convenience init(type: AuthenticationType) {
        self.init(frame: .zero)
        switch type {
        case .login:
            let emailAddress = TextFieldType.emailAdress.getCustomTextField()
            let password = TextFieldType.password.getCustomTextField()
            
            let textFields = [emailAddress, password]
            addArrengedSubviews(textFields)
            setTextFieldHeightConstraints(for: textFields)
            setDelegate(for: textFields)
            configureReturnKeyType(for: textFields)
        case .signUp:
            let name = TextFieldType.userName.getCustomTextField()
            let emailAddress = TextFieldType.emailAdress.getCustomTextField()
            let password = TextFieldType.password.getCustomTextField()
            let confirmPassword = TextFieldType.confirmPassword.getCustomTextField()
            
            let textFields = [name, emailAddress, password, confirmPassword]
            addArrengedSubviews(textFields)
            setTextFieldHeightConstraints(for: textFields)
            setDelegate(for: textFields)
            configureReturnKeyType(for: textFields)
        case .none:
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        spacing = 26
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureReturnKeyType (for texField: [CustomTextField]) {
        var index = 0
        while index < texField.count - 1 {
            texField[index].returnKeyType = .next
            index += 1
        }
        texField[texField.count - 1].returnKeyType = .done
    }
    
    private func addArrengedSubviews(_ subviews: [CustomTextField]) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
    private func setTextFieldHeightConstraints(for textFields: [CustomTextField]) {
        textFields.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 54).isActive = true
        }
    }
    
    private func setDelegate(for textField: [CustomTextField]){
        textField.forEach{ $0.delegate = self}
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            guard let textFieldIndex = self.subviews.firstIndex(of: textField) else { fatalError() }
            textField.resignFirstResponder()
            let nextTextField = self.subviews[textFieldIndex + 1]
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

private class CustomTextField: UITextField {
    
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
        buttonLine.frame = CGRect(
            x: 0,
            y: self.bounds.maxY,
            width: self.bounds.width,
            height: 1
        )
    }
}

private enum TextFieldType {
    case userName
    case emailAdress
    case password
    case confirmPassword
    
    private var placeholder: String {
        switch self {
        case .userName:
            return "Name"
        case .emailAdress:
            return "Email"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
    
    func getCustomTextField() -> CustomTextField {
        switch self {
        case .userName:
            let name = CustomTextField(placeholder: placeholder)
            name.textContentType = .name
            name.returnKeyType = .next
            return name
        case .emailAdress:
            let email = CustomTextField(placeholder: placeholder)
            email.textContentType = .emailAddress
            email.autocapitalizationType = .none
            email.keyboardType = .emailAddress
            email.returnKeyType = .next
            return email
        case .password:
            let password = CustomTextField(placeholder: placeholder)
            password.textContentType = .password
            password.autocapitalizationType = .none
            password.isSecureTextEntry = true
            password.returnKeyType = .next
            return password
        case .confirmPassword:
            let confirmPassword = CustomTextField(placeholder: placeholder)
            confirmPassword.textContentType = .password
            confirmPassword.autocapitalizationType = .none
            confirmPassword.isSecureTextEntry = true
            confirmPassword.returnKeyType  = .done
            return confirmPassword
        }
    }
}
