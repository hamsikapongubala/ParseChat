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

    
    @IBAction func onLogin(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user:PFUser?, error: Error?) in
            
            if let error = error{
                print("User log in failed: \(error.localizedDescription)")
                self.createAlert(title: "Wrong Credentials", message : "Try Again with Correct Credentials")
            }else{
                print("User logged in successfully")
                self.performSegue(withIdentifier : "LoginSegue", sender : nil)
            }
            
            }
        
    }
    
    func createAlert(title : String, message : String){
        let Alert = UIAlertController(title : title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            Alert.dismiss(animated: true, completion: nil)}))
        self.present(Alert, animated: true, completion:nil)
        
    }
    

}
