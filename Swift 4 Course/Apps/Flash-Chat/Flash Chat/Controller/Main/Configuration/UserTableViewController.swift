//
//  UserTableViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase

class UserTableViewController: UITableViewController {
    let userImageCellID: String = "userImageCellID"
    let displayNameCellID: String = "displayNameCellID"
    
    var user: User! {
        didSet {
            tableView.reloadData()
        }
    }
    
    let numberOfRows: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let authenticatedUser = Auth.auth().currentUser else {
            print("Could not resolve user to populate views...")
            navigationController?.popViewController(animated: true)
            return
        }
        
        navigationItem.title = "Profile"
        
        setupTableView()
        user = authenticatedUser
    }

    // MARK: - Views Setup
    func setupTableView() {
        tableView.register(UserImageCell.self, forCellReuseIdentifier: userImageCellID)
        tableView.register(DisplayNameCell.self, forCellReuseIdentifier: displayNameCellID)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: userImageCellID, for: indexPath) as! UserImageCell
            
            if let url = user.photoURL {
                cell.userImageView.loadImageWithUrlString(urlString: url.absoluteString)
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: displayNameCellID, for: indexPath) as! DisplayNameCell
            
            cell.displayName = user.email
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let cell = tableView.cellForRow(at: indexPath) as! DisplayNameCell
            cell.textFieldView.enableTextField()
            enableEditingMode()
            break
        default:
            break
        }
    }
    
    
    // MARK: - Cell Editing
    
    // Adds the left and right barButtonItems to handle edition
    func enableEditingMode() {
        let cancelItem: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(userFinishedEditing(_:)))
        let doneItem: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(userFinishedEditing(_:)))
        
        // Tags will be used to recover which button was clicked in userFinishedEditing(_:)
        cancelItem.tag = 0
        doneItem.tag = 1
        
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = doneItem
    }
    
     // Removes the left and right barButtonItems
    func disableEditingMode() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        navigationItem.hidesBackButton = false
    }
    
    // Handler for when editing is finished
    @objc func userFinishedEditing(_ sender: UIBarButtonItem) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            print("Could not resolve indexPath for selected row...")
            return
        }
        
        switch indexPath.row {
        case 1:
            let cell = tableView.cellForRow(at: indexPath) as! DisplayNameCell
            let canceled = (sender.tag == 0)
            finishEditingDisplayName(onCell: cell, userCanceled: canceled)
            break
        default:
            break
        }
    }
    
    func finishEditingDisplayName(onCell cell: DisplayNameCell, userCanceled canceled: Bool) {
        cell.textFieldView.disableTextField()
        disableEditingMode()
        if canceled {
            // Canceled, put back old displayName
            cell.displayName = user.email
        } else { // Done
            // TODO: Send POST request to Firebase to change user's displayName
            print("Should perform POST to update displayName...")
        }
    }
}
