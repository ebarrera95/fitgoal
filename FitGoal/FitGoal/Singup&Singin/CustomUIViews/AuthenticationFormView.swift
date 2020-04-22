//
//  SingUpForm.swift
//  FitGoal
//
//  Created by Eliany Barrera on 20/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol AuthenticationFormViewDelegate: AnyObject {
    func userDidEndEditingSection(withTextFieldType textFieldType: TextFieldType, input: String)
}

class AuthenticationFormView: UIStackView, UITextFieldDelegate {
    
    weak var delegate: AuthenticationFormViewDelegate?
    
    private var sections = [AuthenticationFormSectionView]()
    
    convenience init(type: AuthenticationType) {
        
        self.init(frame: .zero)
        switch type {
        case .login:
            let emailAddress = AuthenticationFormSectionView(textFieldType: .emailAddress)
            let password = AuthenticationFormSectionView(textFieldType: .password)
            
            sections = [emailAddress, password]
            configureFormSections(sections: sections)
        case .signUp:
            let name = AuthenticationFormSectionView(textFieldType: .userName)
            let emailAddress = AuthenticationFormSectionView(textFieldType: .emailAddress)
            let password = AuthenticationFormSectionView(textFieldType: .password)
            let confirmPassword = AuthenticationFormSectionView(textFieldType: .confirmPassword)
            
            sections = [name, emailAddress, password, confirmPassword]
            configureFormSections(sections: sections)
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
    
    private func configureFormSections(sections: [AuthenticationFormSectionView]) {
        for section in sections {
            addArrangedSubview(section)
            section.textField.delegate = self
            setSectionConstraints(for: section)
            section.textField.returnKeyType = (section == sections.last) ? .done : .next
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for index in sections.indices  {
            if sections[index].textField == textField {
                if textField.returnKeyType == .next {
                    textField.resignFirstResponder()
                    sections[index + 1].textField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
                return true
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for index in sections.indices {
            if sections[index].textField == textField {
                sections[index].message = ""
                return
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for index in sections.indices {
            if sections[index].textField == textField {
                let userInput = textField.text ?? ""
                let textFieldType = sections[index].textFieldType
                delegate?.userDidEndEditingSection(withTextFieldType: textFieldType, input: userInput)
            }
        }
    }
    
    func showAuthenticationMessage(message: String, inSectionWithTextFieldType textFieldType: TextFieldType) {
        for view in sections {
            if view.textFieldType == textFieldType {
                view.message = message
                return
            }
        }
    }
    
    // MARK: -Constraints

    private func setSectionConstraints(for section: AuthenticationFormSectionView) {
            section.translatesAutoresizingMaskIntoConstraints = false
            section.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}

private class AuthenticationFormSectionView: UIView, UITextFieldDelegate {
    
    let textFieldType: TextFieldType
    let textField: UITextField
    
    var message: String = "" {
        didSet {
            formatMessageLabel(label: messageLabel, with: message)
        }
    }
    
    private let buttonLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return line
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
        self.textField = UITextField(textField: textFieldType)
        super.init(frame: .zero)
        
        let subviews = [
            textField,
            buttonLine,
            messageLabel
        ]
        self.addMultipleSubviews(subviews)
        setMessageLabelConstraints()
        
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
    
    private func formatMessageLabel(label: UILabel, with title: String)  {
        label.attributedText = title.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: .red,
            kern: 0.12
        )
    }
    
    private func setMessageLabelConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.bottomAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
