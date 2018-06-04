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
    private let configCellID = "configCellID"
    
    var configurationOptions: [ConfigurationItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConfigurationOptions()
    }
    
    // MARK: - Views Setup
    func setupTableView() {
        tableView.register(ConfigurationCell.self, forCellReuseIdentifier: configCellID)
        
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return configurationOptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: configCellID, for: indexPath) as! ConfigurationCell
        
        cell.configuration = configurationOptions[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
