//
//  NSAttributeString+.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

extension String {
    func formattedText(font: String, size: CGFloat, color: UIColor, kern: CGFloat, lineSpacing: CGFloat = 1.0) -> NSAttributedString {
        let text = self
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: font, size: size)!,
            .foregroundColor: color,
            .kern: kern,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        let attributeText = NSAttributedString(string: text, attributes: atributes)
        return attributeText
    }
}
