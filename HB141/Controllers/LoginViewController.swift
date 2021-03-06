//
//  LoginViewController.swift
//  HB141
//
//  Created by Bailey Bercik on 3/5/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController, GIDSignInUIDelegate, LoginButtonDelegate, GIDSignInDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var invalidLogIn: UILabel!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var facebookLoginContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.contentMode = UIViewContentMode.scaleAspectFit
        
        signUp.backgroundColor = nil
        signUp.tintColor = UIColor.white
        forgotPassword.backgroundColor = nil
        forgotPassword.tintColor = UIColor.white
        Username.backgroundColor = UIColor.white
        Password.backgroundColor = UIColor.white
        
        self.view.applyGradient(colours: [ColorConstants.gradientPrimaryDark, ColorConstants.gradientPrimary])
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        Username.delegate = self
        Password.delegate = self
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.delegate = self
        loginButton.center = facebookLoginContainer.center
        
        view.addSubview(loginButton)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func login(_ sender: Any) {
        if Username.text == nil {
            
        } else if Password.text == nil {
            
        } else {
            AuthManager.shared.loginStandard(username: Username.text!, password: Password.text!) {
                (isSuccessful) -> Void in
                if isSuccessful {
                    self.Password.resignFirstResponder()
                    self.toMain()
                } else {
                    self.invalidLogIn.isHidden = false
                }
            }
        }
        
    }
    
    func toMain() {
        //self.performSegue(withIdentifier: "toMain", sender: self)
        
        //bit of a hack - otherwise segue throws warning on first login from google
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = mainVC
        
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        AuthManager.shared.loginFacebook(loginResult: result) {
            (isSuccessful) -> Void in
            if (isSuccessful) {
                self.toMain()
            } else {
                //error
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signOutError as NSError {
            print("Error signing out with Facebook: \(signOutError)")
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error) != nil {
            return
        }
        
        AuthManager.shared.loginGoogle(user: user) {
            (_ isSuccessful) -> Void in
            if (isSuccessful) {
                self.toMain()
            } else {
                //error
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //Code for when user disconnects from app
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == Username  {
            Username.resignFirstResponder()
            Password.becomeFirstResponder()
        } else {
            Password.resignFirstResponder()
        }
        return true
    }
}


extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
