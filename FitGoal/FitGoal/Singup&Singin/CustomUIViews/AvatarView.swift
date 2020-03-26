//
//  AvatarManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 24/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

protocol AvatarViewDelegate: AnyObject {
    func userWillChangeAvatar()
}

class AvatarView: UIView {
    
    let avatarIcon = UIButton()
    weak var delegate: AvatarViewDelegate?
    
    convenience init(authenticationType: AuthenticationType) {
        self.init(frame: .zero)
        switch authenticationType.self {
        case .signUp:
            let image = UIImage(imageLiteralResourceName: "addAvatar")
            avatarIcon.setImage(image ,for: .normal)
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            avatarIcon.addGestureRecognizer(tap)
        default:
            avatarIcon.isUserInteractionEnabled = false
            let image = UIImage(imageLiteralResourceName: "icon_logo")
            avatarIcon.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarIcon.frame = self.bounds
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
