//
//  SettingsViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, SettingHeaderViewDelegate {
    
    private let userInfoCellsContent: [UserPreference] = [
        UserPreference(preferenceName: "Height", preferenceImage: UIImage(imageLiteralResourceName: "height"), preferenceValue: "173"),
        UserPreference(preferenceName: "Weight", preferenceImage: UIImage(imageLiteralResourceName: "weight"), preferenceValue: "135 LB"),
        UserPreference(preferenceName: "Gender", preferenceImage: UIImage(imageLiteralResourceName: "gender"), preferenceValue: "Female"),
        UserPreference(preferenceName: "Age", preferenceImage: UIImage(imageLiteralResourceName: "age"), preferenceValue: "28"),
        UserPreference(preferenceName: "Goals", preferenceImage: UIImage(imageLiteralResourceName: "goal"), preferenceValue: "")
    ]
    
    private let accountInformation: [AccountInfoCellType] = [
        .notifications(accessoryView: UISwitch()),
        .accountInfo(accessoryType: .disclosureIndicator)
    ]

    private var isEditModeEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        self.tableView.tableHeaderView = SettingHeaderView(
            frame: CGRect(x: 0, y: 0, width: 0, height: 250),
            userName: "Eliany Barrera",
            userFitnessLevel: "Intermediate",
            userProfileImage: nil
        )
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.identifier)
        self.tableView.register(AccountInfoCell.self, forCellReuseIdentifier: AccountInfoCell.identifier)

        if let headerView = self.tableView.tableHeaderView as? SettingHeaderView {
            headerView.delegate = self
        }
    }
    
    func userWillEditProfile() {
        isEditModeEnabled = true
        tableView.reloadSections([SettingsTableViewSection.userInfo.rawValue], with: .none)
    }
    
    func userDidEditProfile() {
        isEditModeEnabled = false
        tableView.reloadSections([SettingsTableViewSection.userInfo.rawValue], with: .none)
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
            return userInfoCellsContent.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifier, for: indexPath)
            guard let userInfoCell = cell as? UserInfoCell else { fatalError() }
            userInfoCell.userPreference = userInfoCellsContent[indexPath.row]
            userInfoCell.selectionStyle = .none
            if isEditModeEnabled {
                userInfoCell.enableEditMode()
            } else {
                userInfoCell.disableEditMode()
            }
            return userInfoCell
        case .accountInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountInfoCell.identifier, for: indexPath)
            guard let accountInfoCell = cell as? AccountInfoCell else { fatalError() }
            accountInfoCell.selectionStyle = .none
            accountInfoCell.cellType = accountInformation[indexPath.row]
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

private enum SettingsTableViewSection: Int, CaseIterable {
    case userInfo
    case accountInfo
}

struct UserPreference {
    let preferenceName: String
    let preferenceImage: UIImage
    let preferenceValue: String
}

enum AccountInfoCellType {
    case notifications(accessoryView: UIView)
    case accountInfo(accessoryType: UITableViewCell.AccessoryType)
    
    var name: String {
        switch self {
        case .notifications:
            return "Notifications"
        case .accountInfo:
            return "Account Info"
        }
    }
}
