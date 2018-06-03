//
//  WelcomeViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForUser()
    }

    func checkForUser() {
        registerButton.isEnabled = false
        loginButton.isEnabled = false
        SVProgressHUD.show()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                enterApp()
            }
            
            self.registerButton.isEnabled = true
            self.loginButton.isEnabled = true
            SVProgressHUD.dismiss()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
