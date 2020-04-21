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
    
    weak var delegate: AuthenticationFormViewDelegate?
    
    private var containerViews = [TextFieldContainerView]()
    
    convenience init(type: AuthenticationType) {
        
        self.init(frame: .zero)
        switch type {
        case .login:
            let emailAddress = TextFieldContainerView(textFieldType: .emailAddress)
            let password = TextFieldContainerView(textFieldType: .password)
            
            containerViews = [emailAddress, password]
            
            configureSectionSubviews(textFields: containerViews)
        case .signUp:
            let name = TextFieldContainerView(textFieldType: .userName)
            let emailAddress = TextFieldContainerView(textFieldType: .emailAddress)
            let password = TextFieldContainerView(textFieldType: .password)
            let confirmPassword = TextFieldContainerView(textFieldType: .confirmPassword)
            
            containerViews = [name, emailAddress, password, confirmPassword]
            configureSectionSubviews(textFields: containerViews)
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
    
    private func configureSectionSubviews(textFields: [TextFieldContainerView]) {
        for textField in textFields {
            addArrangedSubview(textField)
            textField.textField.delegate = self
            setTextFieldHeightConstraints(for: textField)
            textField.textField.returnKeyType = (textField == textFields.last) ? .done : .next
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for index in containerViews.indices  {
            if containerViews[index].textField == textField {
                if textField.returnKeyType == .next {
                    textField.resignFirstResponder()
                    containerViews[index + 1].textField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
                return true
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextFieldDidBeginEditing")
        for index in containerViews.indices {
            if containerViews[index].textField == textField {
                containerViews[index].errorMessage = ""
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for index in containerViews.indices {
            if containerViews[index].textField == textField {
                let text = textField.text ?? ""
                delegate?.userDidEndEditing(textFieldType: containerViews[index].textFieldType, with: text)
            }
        }
    }
    
    func showAuthenticationMessage(message: String, in textFieldType: TextFieldType) {
        for view in containerViews {
            if view.textFieldType == textFieldType {
                view.errorMessage = message
                return
            }
        }
    }
    
    // MARK: -Constraints

    private func setTextFieldHeightConstraints(for textField: TextFieldContainerView) {
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}

private class TextFieldContainerView: UIView, UITextFieldDelegate {
    
    let textFieldType: TextFieldType
    let textField: UITextField
    
    var errorMessage: String? {
        didSet {
            if let error = errorMessage {
                errorMessageLabel.isHidden = !errorMessageLabel.isHidden
                formatErrorMessageLabel(label: errorMessageLabel, with: error)
            }
        }
    }
    
    private let buttonLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return line
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
        self.textField = UITextField(textField: textFieldType)
        super.init(frame: .zero)
        self.addSubview(textField)
        self.addSubview(buttonLine)
        self.addSubview(errorMessageLabel)
        setErrorLabelConstraints()
        
        textField.delegate = self
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
        textField.frame = self.bounds
    }
    
    private func formatErrorMessageLabel(label: UILabel, with title: String)  {
        label.attributedText = title.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: .red,
            kern: 0.12
        )
        label.isHidden = false
    }
    
    private func setErrorLabelConstraints() {
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: self.bottomAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
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
