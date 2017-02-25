//
//  ChatCell.swift
//  ChatWithParse
//
//  Created by Barbara Ristau on 2/25/17.
//  Copyright © 2017 FeiLabs. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var chatMessage: UILabel!
  
  var message: PFObject! {
    
    didSet{
      
      self.chatMessage.text = message["text_message"] as? String

      print("Chat Message: \(message["text_message"]!)")
      print("User: \(message["user"])")
      
      let userObject = message["user"]! as! PFUser
      
      if let userName = userObject["username"] {
        print("UserName = \(userName)")
        userNameLabel.text = "@" + String(describing: userName)
      } else {
               userNameLabel.text = "Test User"
       }
      
    }
    
  }
  
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
  
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
