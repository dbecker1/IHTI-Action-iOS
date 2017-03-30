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

class LoginViewController: UIViewController, GIDSignInUIDelegate, LoginButtonDelegate {
    

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var facebookLoginContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
        FIRAuth.auth()?.signIn(withEmail: Username.text!, password: Password.text!) {
            (user, error) in
            if error != nil {
                print("Login Unsuccessful")
            } else {
                print("Login Successful!!")
            }
        }
    }
    
    func loginExternal(credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential) {
            (user, error) in
            if error != nil {
                print("Login Unsuccessful")
            } else {
                print("Login Successful")
            }
        }
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print("Login Error: \(error)")
        case .success(_, _, let accessToken):
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            loginExternal(credential: credential)
        default:
            print("Facebook Login Result neither Success or Failure")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signOutError as NSError {
            print("Error signing out with Facebook: \(signOutError)")
        }
        
    }
}
