//
//  LoginViewController.swift
//  ChatWithParse
//
//  Created by Barbara Ristau on 2/15/17.
//  Copyright © 2017 FeiLabs. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onSignUp(_ sender: Any) {
    print("sign up")
    
    
    let newUser = PFUser()
    newUser.username = usernameTextField.text
    newUser.password = passwordTextField.text
    
    newUser.signUpInBackground{ (success: Bool, error: Error?) -> Void in
      
      if success {
        print("Yay, created a user")
      } else {
        print("Error: \(error?.localizedDescription)")
        // if error.code == 202 {
        // print("User name is taken")  // parse error codes not showing
      }
      
    }
    
  }

  @IBAction func onLogin(_ sender: Any) {
    print("login")
    
    PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) -> Void in
      
      if user != nil {
        print("You're logged in!")
        self.performSegue(withIdentifier: "ChatSegue", sender: nil)
      
      } else{
      print("error: ")
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
