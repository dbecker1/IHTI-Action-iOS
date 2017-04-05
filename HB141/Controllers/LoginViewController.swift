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
import FacebookCore

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
                print("Login Successful")
                self.toMain()
                
            }
        }
    }
    
    func loginExternal(credential: FIRAuthCredential, callback : (() -> Void)!) {
        FIRAuth.auth()?.signIn(with: credential) {
            (user, error) in
            if error != nil {
                print("Login Unsuccessful")
            } else {
                print("Login Successful")
                if (callback != nil) {
                    callback()
                }
                self.toMain()
            }
        }
    }
    
    func toMain() {
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print("Login Error: \(error)")
        case .success(_, _, let accessToken):
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            loginExternal(credential: credential) {
                let current = FIRAuth.auth()?.currentUser
                if (current?.email == nil) { // this is a new user and you need to add their email
                    let params = ["fields" : "email"]
                    let graphRequest = GraphRequest(graphPath: "me", parameters: params)
                    graphRequest.start {
                        (urlResponse, requestResult) in
                        
                        switch requestResult {
                        case .failed(let error):
                            print("error in graph request:", error)
                            break
                        case .success(let graphResponse):
                            if let responseDictionary = graphResponse.dictionaryValue {
                                let email = responseDictionary["email"] as? String
                                
                                //TODO: Add check to see if previous user exists with this email, and then merge
                                current?.updateEmail(email!, completion: nil)
                            }
                        }
                    }
                }
            }
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
