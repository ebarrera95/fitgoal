//
//  NSAttributeString+.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

extension String {
    func formattedText(font: String, size: CGFloat, color: UIColor, kern: CGFloat) -> NSAttributedString {
        let text = self
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: font, size: size)!,
            .foregroundColor: color,
            .kern: kern
        ]
        let attributeText = NSAttributedString(string: text, attributes: atributes)
        return attributeText
    }
}

