//
//  ConfigurationViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-03.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ConfigurationViewController: UITableViewController {
    private let userConfigCellID: String = "headerCellID"
    private let generalConfigCellID: String = "configCellID"
    
    var configurationOptions: [ConfigurationItem] = []
    let numberOfsections: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConfigurationOptions()
    }
    
    // MARK: - Views Setup
    func setupTableView() {
        tableView.register(ConfigurationCell.self, forCellReuseIdentifier: generalConfigCellID)
        tableView.register(UserConfigCell.self, forCellReuseIdentifier: userConfigCellID)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .none
    }
    
    // MARK: - Configuration Data Setup
    func setupConfigurationOptions() {
        let optionsDict: [[String:String]] = [
            ["text": "Log out", "icon": "off-icon"]
        ]
        
        for optDict in optionsDict {
            if let text = optDict["text"], let iconName = optDict["icon"] {
                let config = ConfigurationItem(text: text, iconName: iconName)
                configurationOptions.append(config)
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfsections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return configurationOptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // User Configuration Cell
            let userConfigCell = tableView.dequeueReusableCell(withIdentifier: userConfigCellID, for: indexPath) as! UserConfigCell
            userConfigCell.user = Auth.auth().currentUser
            return userConfigCell
        default:
            let configCell = tableView.dequeueReusableCell(withIdentifier: generalConfigCellID, for: indexPath) as! ConfigurationCell
            configCell.configuration = configurationOptions[indexPath.row]
            return configCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == numberOfsections - 1 ? 0 : 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: // Go to User Configuration Handler Section
            userConfigurationHandler()
            break
        case 1: // Go to General Configuration Handler Section
            generationConfigurationHandler(indexPath: indexPath)
            break
        default:
            break
        }
        
    }
    
    //MARK: - USER CONFIGURATION SECTION HANDLER
    func userConfigurationHandler() {
        // TODO: go to user configuration view controller
        let userVC = UserTableViewController(style: .plain)
        navigationController?.pushViewController(userVC, animated: true)
    }
    
    //MARK: - GENERAL CONFIGURATION SECTION HANDLER
    func generationConfigurationHandler(indexPath: IndexPath) {
        switch configurationOptions[indexPath.row].text {
        case "Log out":
            logoutPressed()
            break
        default:
            break
        }
    }
    
    //MARK: - Log Out
    func logoutPressed() {
        do {
            try Auth.auth().signOut()
            leaveApp()
        } catch let error {
            SVProgressHUD.showError(withStatus: "Could not log out. Description: \(error.localizedDescription)")
        }
    }
}
