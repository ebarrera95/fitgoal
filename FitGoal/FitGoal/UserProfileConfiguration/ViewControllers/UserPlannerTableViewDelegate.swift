//
//  UserPlannerTableViewDelegate.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit
class UserPlannerTableViewDelegate: NSObject, UITableViewDelegate {
    
    let footerHeight: CGFloat = 16
    let appPreferences = AppPreferences()
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserPlannerTableViewCell else { fatalError() }
        appPreferences.trainingIntensity = cell.trainingProgram?.trainingLevel.rawValue
    }
}
