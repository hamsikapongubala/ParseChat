//
//  SignUpViewController.swift
//  ParseChat
//
//  Created by Hamsika Pongubala on 9/30/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
   
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        
        registerUser()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

       //registerUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.email = emailField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
            
        }
    }

  
    
}
