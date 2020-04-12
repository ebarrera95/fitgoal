//
//  SingUpForm.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol AuthenticationFormViewDelegate: AnyObject {
    func userDidEndEditing(textFieldType: TextFieldType, with text: String)
}

class AuthenticationFormView: UIStackView, UITextFieldDelegate {
    
    var placeholderError: String?
    
    weak var delegate: AuthenticationFormViewDelegate?
    
    convenience init(type: AuthenticationType) {
        self.init(frame: .zero)
        switch type {
        case .login:
            let emailAddress = CustomTextField(textFieldType: .emailAddress)
            let password = CustomTextField(textFieldType: .password)
            
            let textFields = [emailAddress, password]
            configureSectionSubviews(textFields: textFields)
        case .signUp:
            let name = CustomTextField(textFieldType: .userName)
            let emailAddress = CustomTextField(textFieldType: .emailAddress)
            let password = CustomTextField(textFieldType: .password)
            let confirmPassword = CustomTextField(textFieldType: .confirmPassword)
            
            let textFields = [name, emailAddress, password, confirmPassword]
            configureSectionSubviews(textFields: textFields)
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
    
    private func configureSectionSubviews(textFields: [CustomTextField]) {
        for textField in textFields {
            addArrangedSubview(textField)
            textField.delegate = self
            setTextFieldHeightConstraints(for: textField)
            textField.returnKeyType = (textField == textFields.last) ? .done : .next
        }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? CustomTextField {
            guard let text = textField.text else { fatalError() }
            delegate?.userDidEndEditing(textFieldType: textField.textFieldType, with: text)
        }
    }
    
    // MARK: -Constraints

    private func setTextFieldHeightConstraints(for textField: CustomTextField) {
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}

private class CustomTextField: UITextField {
    let textFieldType: TextFieldType
    
    private let buttonLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return line
    }()
    
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
        super.init(frame: .zero)
        self.attributedPlaceholder = textFieldType.placeholder.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
        self.textContentType = textFieldType.textContentType
        self.autocapitalizationType = textFieldType.autocapitalizationType
        self.isSecureTextEntry = textFieldType.isSecureTextEntry
        self.keyboardType = textFieldType.keyboardType
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

enum TextFieldType {
    case userName
    case emailAddress
    case password
    case confirmPassword
    
   var placeholder: String {
        switch self {
        case .userName:
            return "Name"
        case .emailAddress:
            return "Email"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
    
    var textContentType: UITextContentType {
        switch self {
        case .userName:
            return .name
        case .emailAddress:
            return .emailAddress
        case .password:
            return .password
        case .confirmPassword:
            return .password
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        switch self {
        case .userName:
            return .sentences
        case .emailAddress, .password, .confirmPassword:
            return .none
        }
    }
    
    var isSecureTextEntry: Bool {
        switch self {
        case .userName, .emailAddress:
            return false
        case .password, .confirmPassword:
            return true
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .userName, .password, .confirmPassword:
            return .default
        case .emailAddress:
            return .emailAddress
        }
    }
}
