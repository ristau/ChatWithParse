//
//  Message.swift
//  ChatWithParse
//
//  Created by Barbara Ristau on 2/24/17.
//  Copyright © 2017 FeiLabs. All rights reserved.
//

import Foundation
import Parse



class Message: NSObject {
  
  var text: String?
 
  init(chatText: String) {
    
    text = chatText
  }
  
  class func createNewMessage(message: Message, withCompletion completion: PFBooleanResultBlock?) {
    
    let Message = PFObject(className: "Message")
    Message["text_message"] = message.text
   
    Message["user"] = PFUser.current()
    let user = PFUser.current()
    let author = user!["username"]
    Message["author"] = author 
    

 //   let _firstname = user!["firstname"]
    
//    Message.saveInBackground(block: completion)
    Message.saveInBackground { (success: Bool, error: Error?) -> Void in
      
      if success {
        print("Posted the message: \(Message["text_message"]!)")
      }
      else {
        print("Something went wrong")
      }
    }

    
  }

  
}



