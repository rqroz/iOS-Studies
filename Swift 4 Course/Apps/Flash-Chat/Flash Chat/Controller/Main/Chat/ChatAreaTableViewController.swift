//
//  ChatAreaTableViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-07.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class ChatAreaTableViewController: BaseTableViewController {
    let chatCellID: String = "chatCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chats"
        view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func setupTableView() {
        super.setupTableView()
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: chatCellID)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatCellID, for: indexPath) as! ChatCell

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Change current code to actual implementation
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let messagesVC = mainStoryBoard.instantiateViewController(withIdentifier: "chatMessagesVC")
        navigationController?.pushViewController(messagesVC, animated: true)
    }
}
