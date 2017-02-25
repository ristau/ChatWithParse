//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Barbara Ristau on 2/15/17.
//  Copyright © 2017 FeiLabs. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var chatMessageTextView: UITextView!

  @IBOutlet weak var createMessageButton: UIButton!
  
  var placeholderText: String = "Enter chat message here"
  var message: Message?
 
  var messageArray: [PFObject] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self

      createMessageButton.layer.cornerRadius = 4
      chatMessageTextView.layer.cornerRadius = 4
      
      chatMessageTextView.delegate = self
      chatMessageTextView.isUserInteractionEnabled = true
      applyPlaceholderStyle(text: chatMessageTextView, phText: placeholderText)
    
      fetchParsePosts()
      
      Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
      
      tableView.estimatedRowHeight = 120
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.reloadData()
    }
  
  // MARK: - TEXT VIEW METHODS
  
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    if textView == chatMessageTextView && textView.text == placeholderText {

      moveCursorToStart(textView: chatMessageTextView)
      
    }
    return true
  }
  
  func moveCursorToStart(textView: UITextView) {
    
    DispatchQueue.main.async {
      self.chatMessageTextView.selectedRange = NSMakeRange(0, 0)
    }
    
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
   
    let newLength = textView.text.utf16.count + text.utf16.count - range.length
    
    if newLength > 0 {
      
      if textView == chatMessageTextView && chatMessageTextView.text == placeholderText
      {
        applyNonPlaceholderStyle(text: textView)
        chatMessageTextView.text = ""
      }
    }
  
    return true
  }
  
  func applyNonPlaceholderStyle(text: UITextView)
  {
    chatMessageTextView.textColor = UIColor.darkText
    chatMessageTextView.alpha = 1.0
  }
  
  func applyPlaceholderStyle(text: UITextView, phText: String) {
    chatMessageTextView.textColor = UIColor.blue
    chatMessageTextView.text = placeholderText
  }
  
// MARK: - Actions
  
  func createMessage(completion: (_ success: Bool) -> Void) {
    
    message = Message(chatText: chatMessageTextView.text!)
    completion(true)
    
  }

  @IBAction func onCreate(_ sender: UIButton) {
    print("Clicked on create")
    
    createMessage { (success) -> Void in
      if success {
        
        Message.createNewMessage(message: message!) { (success: Bool, error: Error?) -> Void in
      
          if success {
            print("Successful Post to Parse")
          }
          else {
            print("Can't post to parse")
          }
        }
      }
    }
  }
  
  func onTimer() {
    
      print("Fetching Parse Posts")
      fetchParsePosts()
  }
  
  
  // MARK: - TableView Methods
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
    
    let message = messageArray[indexPath.row]
    cell.message = message
    
    return cell
  }
  
  //MARK: - FETCH POSTS FROM PARSE
  
  func fetchParsePosts() {
    
    let query = PFQuery(className: "Message")
    
    query.order(byDescending: "_created_at")
    query.includeKey("user")
    query.limit = 20
    
    query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) -> Void in
      if let messages = messages {
        self.messageArray = messages
        self.tableView.reloadData()
        print("Retrieved the messages")
      } else {
        print(error!.localizedDescription as Any)
      }
    }
    
    self.tableView.reloadData()
    
  }

  
  
  
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
