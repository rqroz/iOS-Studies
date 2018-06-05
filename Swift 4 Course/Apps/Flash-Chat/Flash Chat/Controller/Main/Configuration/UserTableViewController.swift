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
    let usernameCellID: String = "usernameCellID"
    
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
        
        setupTableView()
        user = authenticatedUser
    }

    // MARK: - Views Setup
    func setupTableView() {
        tableView.register(UserImageCell.self, forCellReuseIdentifier: userImageCellID)
        tableView.register(UsernameCell.self, forCellReuseIdentifier: usernameCellID)
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: usernameCellID, for: indexPath) as! UsernameCell
            
            cell.username = user.email
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let cell = tableView.cellForRow(at: indexPath) as! UsernameCell
            cell.enableTextField()
            break
        default:
            break
        }
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
