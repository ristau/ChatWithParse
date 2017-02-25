//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Barbara Ristau on 2/15/17.
//  Copyright © 2017 FeiLabs. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextViewDelegate {

  
  @IBOutlet weak var chatMessageLabel: UITextView!
  
  
  @IBOutlet weak var chatMessageTextView: UITextView!
  @IBOutlet weak var createMessageButton: UIButton!
  
  var placeholderText: String = "Enter chat message here"
  var message: Message?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      createMessageButton.layer.cornerRadius = 4
      chatMessageTextView.delegate = self
    //  chatMessageTextView.text = placeholderText
      chatMessageTextView.isUserInteractionEnabled = true
      applyPlaceholderStyle(text: chatMessageTextView, phText: placeholderText)
      
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
  
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
