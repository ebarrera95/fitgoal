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
    
    init(listView: IconListView) {
        listView.delegate = self
    }
    
    func iconListView(_ listView: IconListView, didSelectIcon iconView: WalkthroughIconView) {
        switch iconView.icon.iconType {
        case .currentFitnessLevel(let fitnessLevel):
            appPreferences.fitnessLevel = fitnessLevel
        case .fitnessGoal(let fitnessGoal):
            appPreferences.fitnessGoal = fitnessGoal
        case .gender(let gender):
            appPreferences.userGender = gender
        }
    }
    
    func iconListView(_ listView: IconListView, didDeselectIcon iconView: WalkthroughIconView) {
        switch iconView.icon.iconType {
        case .fitnessGoal:
            appPreferences.fitnessGoal = nil
        case .currentFitnessLevel:
            appPreferences.fitnessLevel = nil
        case .gender:
            appPreferences.userGender = nil
        }
    }
}
