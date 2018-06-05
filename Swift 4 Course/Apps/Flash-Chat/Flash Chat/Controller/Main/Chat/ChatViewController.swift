//
//  ViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    fileprivate let messageCellId = "messageCellId"
    
    let blackView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.5)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var messages: [Message] = []
    var atStart = true
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showBlackView()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //TODO: Set the tapGesture here:
        
        // Observers to update view constraints on keyboard appearance
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Setting up table view
        setupViews()
        retrieveMessages()
    }
    
    //MARK: - Setting up views
    func setupViews(){
        setupBlackView()
        setupTableView()
    }
    
    func setupBlackView() {
        view.addSubview(blackView)
        view.addConstraintToItem(view: blackView, related: view, attribute: .top, multiplier: 1, constant: 0)
        view.addConstraintToItem(view: blackView, related: view, attribute: .right, multiplier: 1, constant: 0)
        view.addConstraintToItem(view: blackView, related: view, attribute: .left, multiplier: 1, constant: 0)
        view.addConstraintToItem(view: blackView, related: view, attribute: .bottom, multiplier: 1, constant: 0)
    }
    
    // MARK: - Observing keyboard appearance
    func changeChatConstraints(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.heightConstraint.constant = 50 + keyboardHeight
            self.view.layoutIfNeeded()
            self.scrollToBottom()
        }, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            print("Could not get keyboard frame to update constraints...")
            return
        }
        changeChatConstraints(keyboardHeight: keyboardFrame.cgRectValue.height)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        changeChatConstraints(keyboardHeight: 0)
    }
    
    // Mark: - Table View Setup
    func setupTableView() {
        messageTableView.register(ChatMessageCell.self, forCellReuseIdentifier: messageCellId)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        messageTableView.separatorStyle = .none
        messageTableView.allowsSelection = false
        
        updateTableViewCells()
    }
    
    func updateTableViewCells() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellId, for: indexPath) as! ChatMessageCell
        
        cell.message = messages[indexPath.row]
        
        return cell
    }
    
    //MARK: - Send & Recieve from Firebase
    @IBAction func sendPressed(_ sender: AnyObject) {
        guard let message = messageTextfield.text, let user = Auth.auth().currentUser else {
            print("Could not retrieve messageTextField's text or user information...")
            return
        }
        
        if message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return }
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child(DefaultSettings.messagesDBIdentifier)
        let messageDict = [
            "sender": user.email,
            "body": message
        ]
        
        messagesDB.childByAutoId().setValue(messageDict) { (error, referenceDB) in
            if error != nil {
                // FAILED TO STORE MESSAGE
                print("Could not send message. Description: \(error!.localizedDescription)")
            } else {
                // STORED MESSAGE SUCCESSFULLY
                print("Message stored successfully.")
                
                self.messageTextfield.text = ""
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
            }
        }
    }
    
    //MARK: - Database Observing
    func retrieveMessages() {
        let messagesDB = Database.database().reference().child(DefaultSettings.messagesDBIdentifier)
        
        messagesDB.observe(.childAdded) { (snapshot) in
            guard let snapshotDict = snapshot.value as? [String:String] else {
                print("Could not recover snapshot values from Firebase's messages DB Observer...")
                return
            }
            guard let sender = snapshotDict["sender"], let body = snapshotDict["body"] else {
                print("Could not resolve sender and/or body elements from snapshotDict...")
                return
            }
            
            
            let newMessage = Message(sender: sender, body: body)
            self.addMessage(message: newMessage)
            
            
            if self.atStart {
                //self.dismissBlackView()
                self.atStart = false
            }
        }
    }
    
    func addMessage(message: Message) {
        messages.append(message)
        
        updateTableViewCells()
        messageTableView.reloadData()
        scrollToBottom()
    }
    
    func scrollToBottom() {
        if !messages.isEmpty {
            let indexPath = IndexPath(item: messages.count - 1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    //MARK: - Loading Status with Black View
    func dismissBlackView(){
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            SVProgressHUD.dismiss()
        }
    }
    
    func showBlackView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            SVProgressHUD.show()
        }, completion: nil)
    }
}
