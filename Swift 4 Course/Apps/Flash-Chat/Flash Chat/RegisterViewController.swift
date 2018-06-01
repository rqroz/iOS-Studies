//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
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
        SVProgressHUD.show()
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print("Could not resolve email or password...")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            SVProgressHUD.dismiss()
            
            if error != nil {
                print("Registartion failed. Description: \(error!.localizedDescription)")
                SVProgressHUD.showError(withStatus: "Failed to register. Please double check the information provided.")
            }else{
                print("Registration successful.")
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        })
        
    } 
    
    
}
