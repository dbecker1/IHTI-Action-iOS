//
//  RegistrationController.swift
//  HB141
//
//  Created by Reema Patel on 3/30/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var errorText: UILabel!

    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.delegate = self
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
    }
    
    
   
    @IBAction func signUp(_ sender: Any) {
        
        if let fullNameText = fullName.text, let emailText = email.text, let passwordText = password.text, let confirmPasswordText = confirmPassword.text {
            
            if passwordText != confirmPasswordText {
                errorText.text = "Passwords do not match."
                errorText.isHidden = false
                return
            }
            if !isValidEmail(testStr: emailText) {
                errorText.text = "Email address must be a valid email."
                errorText.isHidden = false
                return
            }
            
            AuthManager.shared.createUserStandard(emailAddress: emailText, password: passwordText, name:fullNameText) {
                (isSuccessful) -> Void in
                if isSuccessful {
                    self.performSegue(withIdentifier: "toMain", sender: nil)
                } else {
                    self.errorText.text = "Error creating user account."
                    self.errorText.isHidden = false
                }
            }
            
        } else {
            errorText.text = "Please fill out entire form."
            errorText.isHidden = false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullName:
            email.becomeFirstResponder()
            break
        case email:
            password.becomeFirstResponder()
            break
        case password:
            confirmPassword.becomeFirstResponder()
            break
        case confirmPassword:
            confirmPassword.resignFirstResponder()
            break;
        default:
            textField.resignFirstResponder()
            break
        }
        
        return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
  
}
