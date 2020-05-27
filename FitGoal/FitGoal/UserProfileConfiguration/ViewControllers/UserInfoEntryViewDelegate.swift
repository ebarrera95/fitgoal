//
//  UserInfoEntryViewDelegate.swift
//  FitGoal
//
//  Created by Eliany Barrera on 25/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserInfoEntryViewDelegate: NSObject, IconListViewDelegate,  UITextFieldDelegate {
    
    private let appPreferences = AppPreferences()
    private let userProfileType: UserProfileType
    
    init(userInfoEntryView: UIView, userProfileType: UserProfileType) {
        self.userProfileType = userProfileType
        super.init()
        setDelegate(forView: userInfoEntryView)
    }
    
    private func setDelegate(forView userInfoEntryView: UIView) {
        if let userInfoEntryView = userInfoEntryView as? UITextField {
            userInfoEntryView.delegate = self
        } else if let userInfoEntryView = userInfoEntryView as? ListIconView {
            userInfoEntryView.delegate = self
        }
    }
    
    func iconListView(_ listView: ListIconView, didSelectIcon iconView: WalkthroughIconView) {
        switch userProfileType {
        case .fitnessGoal:
            appPreferences.fitnessGoal = iconView.icon.name
        case .fitnessLevel:
            appPreferences.fitnessLevel = iconView.icon.name
        case .gender:
            appPreferences.userGender = iconView.icon.name
        default:
            assertionFailure("ListIconViewDelegate shouldn't be called for views that are not listIconView")
        }
    }
    
    func iconListView(_ listView: ListIconView, didDeselectIcon iconView: WalkthroughIconView) {
        switch userProfileType {
        case .fitnessGoal:
            appPreferences.fitnessGoal = nil
        case .fitnessLevel:
            appPreferences.fitnessLevel = nil
        case .gender:
            appPreferences.userGender = nil
        default:
            assertionFailure("ListIconViewDelegate shouldn't be called for views that are not listIconView")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch userProfileType {
        case .age:
            if let text = textField.text, let age = Int(text) {
                appPreferences.age = age
            }
        case .height:
            if let text = textField.text, let height = Int(text) {
                appPreferences.height = height
            }
        case .weight:
            if let text = textField.text, let weight = Int(text) {
                appPreferences.weight = weight
            }
        default:
            assertionFailure("textFieldDelegate shouldn't be called for views that are not textField")
        }
    }
}
