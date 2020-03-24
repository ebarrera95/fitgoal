//
//  AvatarManager.swift
//  FitGoal
//
//  Created by Eliany Barrera on 24/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import Foundation
import UIKit

protocol UserAvatarDelegate: AnyObject {
    func userWillChangeAvatar()
}

class AvatarManager: UIView {
    
    weak var delegate: UserAvatarDelegate?
    
    var avatarIcon = UIButton()
    
    convenience init(avatarImage: UIImage, authenticationType: AuthenticationType) {
        self.init(frame: .zero)
        
        switch authenticationType.self {
        case .signUp:
            avatarIcon.setImage(avatarImage, for: .normal)
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            avatarIcon.addGestureRecognizer(tap)
        default:
            avatarIcon.isUserInteractionEnabled = false
            avatarIcon.setImage(avatarImage, for: .normal)
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [avatarIcon]
        self.addMultipleSubviews(views)
        //setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarIcon.frame = CGRect(x: bounds.midX - 52, y: 130, width: 104, height: 104)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            delegate?.userWillChangeAvatar()
        default:
            return
        }
    }
}
