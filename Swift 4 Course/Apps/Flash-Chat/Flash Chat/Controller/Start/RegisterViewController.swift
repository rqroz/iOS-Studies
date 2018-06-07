//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        toggleLoader(state: .on)
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print("Could not resolve email or password...")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            toggleLoader(state: .off)
            
            if error != nil {
                print("Registartion failed. Description: \(error!.localizedDescription)")
                SVProgressHUD.showError(withStatus: "Failed to register. Please double check the information provided.")
            }else{
                print("Registration successful.")
                enterApp()
            }
        })
        
    } 
    
    
}
