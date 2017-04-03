//
//  RegistrationController.swift
//  HB141
//
//  Created by Reema Patel on 3/30/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
   
    @IBAction func signUp(_ sender: Any) {
        let fullNameText = fullName.text!
        let emailText = email.text!
        let passwordText = password.text!
        let confPasswordText = confirmPassword.text!
        
        if fullNameText != "" && emailText != "" && passwordText != "" && confPasswordText != "" {
            
            if passwordText == confPasswordText {
                
                //add the user to database
                
            } else {
                print("Passwords do not match.")
            }
            
        } else {
            print("Fill out all fields")
        }
        
    }
  
}
