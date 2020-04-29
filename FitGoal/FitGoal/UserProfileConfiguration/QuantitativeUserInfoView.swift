//
//  QuantitativeUserInfoView.swift
//  FitGoal
//
//  Created by Eliany Barrera on 28/4/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class QuantitativeUserInfoView: UIView {

    private let textField: UITextField = {
        let texField = UITextField()
        texField.backgroundColor = .red
        texField.layer.masksToBounds = true
        return texField
    }()
    
    private let dropDown: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowColor = UIColor(red: 0.51, green: 0.53, blue: 0.64, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        
        let views = [textField, dropDown]
        
        self.addMultipleSubviews(views)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        setTextFieldConstraints()
        setUnitSelectorConstraints()
    }
    
    private func setTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor),
            textField.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setUnitSelectorConstraints() {
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropDown.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dropDown.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dropDown.widthAnchor.constraint(equalToConstant: 64),
            dropDown.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
