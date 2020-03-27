//
//  AvatarManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 24/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

protocol IconViewDelegate: AnyObject {
    func userWillChangeAvatar()
}

class IconView: UIView {
    
    let icon = UIButton()
    weak var delegate: IconViewDelegate?
    
    convenience init(iconType: IconType) {
        self.init(frame: .zero)
        switch iconType.self {
        case .avatarChooser:
            let image = UIImage(imageLiteralResourceName: "addAvatar")
            icon.setImage(image ,for: .normal)
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            icon.addGestureRecognizer(tap)
        case .appIcon:
            icon.isUserInteractionEnabled = false
            let image = UIImage(imageLiteralResourceName: "icon_logo")
            icon.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = self.bounds
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            delegate?.userWillChangeAvatar()
        default:
            return
        }
    }
}

enum IconType {
    case appIcon
    case avatarChooser
}
