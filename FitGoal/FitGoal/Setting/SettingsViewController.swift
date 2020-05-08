//
//  SettingsViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    private let cellInformation: [CellInformation] = [
        CellInformation(cellName: "Height", cellIcon: UIImage(imageLiteralResourceName: "height"), userInformation: "173"),
        CellInformation(cellName: "Weight", cellIcon: UIImage(imageLiteralResourceName: "weight"), userInformation: "135 LB"),
        CellInformation(cellName: "Gender", cellIcon: UIImage(imageLiteralResourceName: "gender"), userInformation: "Female"),
        CellInformation(cellName: "Age", cellIcon: UIImage(imageLiteralResourceName: "age"), userInformation: "28"),
        CellInformation(cellName: "Goals", cellIcon: UIImage(imageLiteralResourceName: "goal"), userInformation: "")
    ]
    
    private let accountInformation: [String] = [
        "Notifications",
        "Account Info"
    ]
    
    private var genderPickerViewIndexPath = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        self.tableView.tableHeaderView = SettingHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 250), userName: "Eliany Barrera", userFitnessLevel: "Intermediate", userProfileImage: nil)
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.identifier)
        self.tableView.register(AccountInfoCell.self, forCellReuseIdentifier: AccountInfoCell.identifier)
        self.tableView.register(GenderPickerViewCell.self, forCellReuseIdentifier: GenderPickerViewCell.identifier)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsTableViewSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settingsSection = SettingsTableViewSection(rawValue: section) else {
            fatalError("Section value should have a corresponding case in the SettingsSection enum")
        }
        
        switch settingsSection {
        case .userInfo:
            return cellInformation.count
        case .accountInfo:
            return accountInformation.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingsSection = SettingsTableViewSection(rawValue: indexPath.section) else {
            fatalError("Section value should have a corresponding case in the SettingsSection enum")
        }
        
        switch settingsSection {
        case .userInfo:
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: GenderPickerViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifier, for: indexPath)
                cell.selectionStyle = .none
                guard let userInfoCell = cell as? UserInfoCell else { fatalError() }
                    userInfoCell.cellInformation = cellInformation[indexPath.row]
                    return userInfoCell
            }
        case .accountInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountInfoCell.identifier, for: indexPath)
            cell.selectionStyle = .none
            guard let accountInfoCell = cell as? AccountInfoCell else { fatalError() }
            accountInfoCell.cellTitle = accountInformation[indexPath.row]
            return accountInfoCell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let settingsSection = SettingsTableViewSection(rawValue: section) else {
            fatalError("Section value should have a corresponding case in the SettingsSection enum")
        }
        
        switch settingsSection {
        case .userInfo:
            return headerView(withText: "user info")
        case .accountInfo:
            return headerView(withText: "account info")
        }
    }
    
    private func headerView(withText text: String) -> UIView {
        let headerView = UIView(frame: .zero)
        let sectionName = UILabel()
        sectionName.attributedText = text.uppercased().formattedText(
            font: "Roboto-Bold",
            size: 15,
            color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
            kern: 0.14
        )
        headerView.addSubview(sectionName)
        sectionName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionName.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            sectionName.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24)
        ])
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.cellForRow(at: indexPath)
        guard let userInfoCell = cell as? UserInfoCell else { return false }
        if userInfoCell.cellInformation?.cellName == "Gender" {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

enum SettingsTableViewSection: Int, CaseIterable {
    case userInfo
    case accountInfo
}

struct CellInformation {
    let cellName: String
    let cellIcon: UIImage
    let userInformation: String
}

