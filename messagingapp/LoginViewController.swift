//
//  LoginViewController.swift
//  messagingapp
//
//  Created by Haruna Yamakawa on 9/1/20.
//  Copyright © 2020 Haruna. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInSelectionChanged(_ sender: Any) {
        // flip boolean
        isSignIn = !isSignIn
        
        // check the bool and set the button and label
        if isSignIn {
            signInLabel.text = "Sign in"
            signInButton.setTitle("Sign in", for: .normal)
        } else {
            signInLabel.text = "Sign up"
            signInButton.setTitle("Sign up", for: .normal)
        }
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // check email and password are not nil
        if let email = emailTextField.text, let pass = passwordTextField.text {
            // check if it's sign in or register
           if isSignIn {
               // sign in the user with firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                // check the user is not nil
                if let u = user {
                    // user is found login
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                    
                } else {
                    // error not log in  show message
                }
            }
           } else {
               // register the user with firebase
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                // check if user is not nil
                if let u = user {
                    // found go to home screen
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                } else {
                    // error show message
                }
            }
           }
        
        }
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
