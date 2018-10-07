//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Hamsika Pongubala on 10/6/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var messages:[PFObject] = []
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = PFUser.current() {
            self.createAlert(title: "Welcome back 😀", message: "Glad you're back \(currentUser.username!)")
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        onTimer()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector
            (ChatViewController.didpullrequest(_refreshControl:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
 
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.rowHeight = 50
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSend(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["user"] = PFUser.current()
        chatMessage["text"] = chatMessageField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    @objc func didpullrequest(_refreshControl: UIRefreshControl){
        updateMessages()
        
    }
    
    func updateMessages(){
        
        let query = PFQuery(className:"Message")
        //        query.whereKey("playerName", equalTo:"Sean Plott")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object["text"] )
                        
                    }
                }
                
                self.messages = objects!
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
            self.refreshControl.endRefreshing()
        }

    }
    
    
    @objc func onTimer(){
       Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        self.updateMessages()
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatTableViewCell
    
       
        cell.messageLabel.text = (messages[indexPath.row]["text"] as? String)!
        cell.usernameLabel.text = (messages[indexPath.row]["user"] as? PFObject)?["username"] as? String ?? "🤖"
        
        
        
//        if let user = messages[indexPath.row]["text"] as? PFUser? {
//            // User found! update username label with username
//            cell.usernameLabel.text = user?.username
//            cell.usernameLabel.text = (messages[indexPath.row]["user"] as? PFObject)?["username"] as? String ?? "EMPTY"
//
//        } else {
//            // No user found, set default username
//            cell.usernameLabel.text = "🤖"
//            //cell.messageLabel.text = (messages[indexPath.row]["text"] as? String)!
//
//        }
        
        return cell
    }
    
    func createAlert(title : String, message : String){
        let Alert = UIAlertController(title : title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            Alert.dismiss(animated: true, completion: nil)}))
        self.present(Alert, animated: true, completion:nil)
        
    }
    
}
