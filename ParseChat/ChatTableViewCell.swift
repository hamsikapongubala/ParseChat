//
//  ChatTableViewCell.swift
//  ParseChat
//
//  Created by Hamsika Pongubala on 10/6/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    public var username: String = "" {
        didSet {
            usernameLabel.text = username
            if username == "EMPTY"{
                usernameLabel.text = "🤖"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   
}
