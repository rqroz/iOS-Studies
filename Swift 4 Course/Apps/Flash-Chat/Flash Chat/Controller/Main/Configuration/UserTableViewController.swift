//
//  UserTableViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase

class UserTableViewController: BaseTableViewController {
    let userImageCellID: String = "userImageCellID"
    let displayNameCellID: String = "displayNameCellID"
    let statusCellID: String = "statusCellID"
    
    var user: User! {
        didSet {
            tableView.reloadData()
        }
    }
    
    let numberOfRows: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let authenticatedUser = Auth.auth().currentUser else {
            print("Could not resolve user to populate views...")
            navigationController?.popViewController(animated: true)
            return
        }
        
        navigationItem.title = "Profile"
        user = authenticatedUser
    }

    // MARK: - Views Setup
    override func setupTableView() {
        super.setupTableView()
        tableView.register(UserImageCell.self, forCellReuseIdentifier: userImageCellID)
        tableView.register(DisplayNameCell.self, forCellReuseIdentifier: displayNameCellID)
        tableView.register(StatusCell.self, forCellReuseIdentifier: statusCellID)
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
            cell.currentText = user.email
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: statusCellID) as! StatusCell
            cell.currentText = "My status goes here"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 { // If not image cell
            let cell = tableView.cellForRow(at: indexPath) as! BaseTextFieldCell
            cell.enableTextField()
            enableEditingMode()
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
        
        if indexPath.row > 0 { // If not image cell
            let cell = tableView.cellForRow(at: indexPath) as! BaseTextFieldCell
            let canceled = (sender.tag == 0)
            finishEditingTextField(onCell: cell, userCanceled: canceled)
        }
    }
    
    func finishEditingTextField(onCell cell: BaseTextFieldCell, userCanceled canceled: Bool) {
        cell.disableTextField()
        disableEditingMode()
        
        if canceled {
            // Canceled, put back old displayName
            cell.resetToCurrentText()
        } else { // Done
            editionHandler(withCell: cell)
        }
    }
    
    func editionHandler(withCell cell: BaseTextFieldCell) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            print("editionHandler(withCell:) Could not resolve indexPath for selected row...")
            return
        }
        
        switch indexPath.row {
        case 1: // User's Display Name Cell
            // TODO: Send POST request to Firebase to change user's displayName
            print("Should perform POST to update displayName...")
            break
        case 2: // User's Status Cell
            // TODO: Send POST request to Firebase to change user's status
            print("Should perform POST to update status...")
            break
        default:
            break
        }
    }
}
