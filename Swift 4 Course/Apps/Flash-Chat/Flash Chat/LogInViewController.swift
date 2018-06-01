//
//  LogInViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print("Could not login.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            SVProgressHUD.dismiss()
            
            if error != nil {
                // ERROR
                print("Error while trying to log in. Description: \(error!.localizedDescription)")
                SVProgressHUD.showError(withStatus: "Failed to log in. Please double check your credentials.")
            }else{
                // SUCCESS
                print("Login successful")
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
    }
    


    
}  
