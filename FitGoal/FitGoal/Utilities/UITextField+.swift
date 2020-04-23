//
//  UITextField+.swift
//  FitGoal
//
//  Created by Eliany Barrera on 21/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    convenience init(textField: TextFieldType) {
        self.init(frame: .zero)
        self.attributedPlaceholder = textField.placeholder.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: UIColor(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0
        )
        self.textContentType = textField.textContentType
        self.autocapitalizationType = textField.autocapitalizationType
        self.isSecureTextEntry = textField.isSecureTextEntry
        self.keyboardType = textField.keyboardType
    }
}
