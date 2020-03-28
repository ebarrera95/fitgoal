//
//  UIView+.swift
//  FitGoal
//
//  Created by Eliany Barrera on 19/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addMultipleSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0)}
    }
}
