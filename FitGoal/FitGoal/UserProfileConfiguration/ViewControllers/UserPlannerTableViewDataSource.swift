//
//  UserPlannerTableViewDataSource.swift
//  FitGoal
//
//  Created by Eliany Barrera on 27/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class UserPlannerTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let trainingPrograms:[TrainingProgram] = [
        TrainingProgram(trainingLevel: .easy, monthsTraining: 6, weeklyFrequency: 2),
        TrainingProgram(trainingLevel: .medium, monthsTraining: 3, weeklyFrequency: 4),
        TrainingProgram(trainingLevel: .intense, monthsTraining: 2, weeklyFrequency: 6)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trainingPrograms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserPlannerTableViewCell.identifier)
        guard let userPlannerCell = cell as? UserPlannerTableViewCell else { fatalError() }
        let trainingProgram = trainingPrograms[indexPath.section]
        userPlannerCell.trainingProgram = trainingProgram
        return userPlannerCell
    }
}
