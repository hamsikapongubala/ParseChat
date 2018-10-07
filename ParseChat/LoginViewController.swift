//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Hamsika Pongubala on 9/30/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    

    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
        loginUser();
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginUser() {
        
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user:PFUser?, error: Error?) in
            
            if let error = error {
                //print("User log in failed: \(error?.localizedDescription)")
                self.createAlert(title: "Error", message : "\(error.localizedDescription)")
            }else{
                print("User logged in successfully")
                self.performSegue(withIdentifier : "loginSegue", sender : nil)
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
