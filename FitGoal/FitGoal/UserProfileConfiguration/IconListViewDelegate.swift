//
//  IconListViewDelegate.swift
//  FitGoal
//
//  Created by Eliany Barrera on 31/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class IconListDelegate: IconListViewDelegate {
    
    private let appPreferences = AppPreferences()
    private let userInfo: QualitativeUserInfo
    
    init(listView: IconListView, qualitativeUserInfo: QualitativeUserInfo) {
        self.userInfo = qualitativeUserInfo
        listView.delegate = self
    }
    
    func iconListView(_ listView: IconListView, didSelectIcon iconView: WalkthroughIconView) {
        switch userInfo {
        case .fitnessGoal:
            switch iconView.icon.iconType {
            case .fitnessLevel(let fitnessLevel):
                appPreferences.fitnessGoal = fitnessLevel
            default:
                return
            }
        case .currentFitnessLevel:
            switch iconView.icon.iconType {
            case .fitnessLevel(let fitnessLevel):
                appPreferences.fitnessLevel = fitnessLevel
            default:
                return
            }
        case .gender:
            switch iconView.icon.iconType {
            case .gender(let gender):
                appPreferences.userGender = gender
            default:
                return
            }
        }
    }
    
    func iconListView(_ listView: IconListView, didDeselectIcon iconView: WalkthroughIconView) {
        switch userInfo {
        case .fitnessGoal:
            appPreferences.fitnessGoal = nil
        case .currentFitnessLevel:
            appPreferences.fitnessLevel = nil
        case .gender:
            appPreferences.userGender = nil
        }
    }
}

enum QualitativeUserInfo {
    case gender
    case currentFitnessLevel
    case fitnessGoal
}
