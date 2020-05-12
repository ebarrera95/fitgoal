//
//  SettingsViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 1/5/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    private let userInfoCellsContent: [UserInfoCellContent] = [
        UserInfoCellContent(cellName: "Height", cellIcon: UIImage(imageLiteralResourceName: "height"), userInformation: "173"),
        UserInfoCellContent(cellName: "Weight", cellIcon: UIImage(imageLiteralResourceName: "weight"), userInformation: "135 LB"),
        UserInfoCellContent(cellName: "Gender", cellIcon: UIImage(imageLiteralResourceName: "gender"), userInformation: "Female"),
        UserInfoCellContent(cellName: "Age", cellIcon: UIImage(imageLiteralResourceName: "age"), userInformation: "28"),
        UserInfoCellContent(cellName: "Goals", cellIcon: UIImage(imageLiteralResourceName: "goal"), userInformation: ">")
    ]

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
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoCellsContent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifier, for: indexPath)
        guard let userInfoCell = cell as? UserInfoCell else { fatalError() }
        userInfoCell.selectionStyle = .none
        userInfoCell.userInfoCellContent = userInfoCellsContent[indexPath.row]
        return userInfoCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: .zero)
        let sectionName = UILabel()
        sectionName.attributedText = "user info".uppercased().formattedText(
            font: "Roboto-Bold",
            size: 15,
            color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
            kern: 0.14
        )
        header.addSubview(sectionName)
        sectionName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionName.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            sectionName.topAnchor.constraint(equalTo: header.topAnchor, constant: 24)
        ])
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

struct UserInfoCellContent {
    let cellName: String
    let cellIcon: UIImage
    let userInformation: String
}

