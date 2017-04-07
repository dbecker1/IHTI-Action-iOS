//
//  MenuViewController.swift
//  HB141
//
//  Created by Daniel Becker on 3/11/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class MenuViewController: UIViewController {
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBackground.backgroundColor = ColorConstants.titleBarColor

        // Do any additional setup after loading the view.
        if let user = FIRAuth.auth()?.currentUser {
            name.text = user.displayName
            email.text = user.email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        do {
            if (FBSDKAccessToken.current() != nil) {
                let loginManager = FBSDKLoginManager()
                loginManager.logOut()
            }
            try FIRAuth.auth()?.signOut()
            let onboarding = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!
            self.present(onboarding, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out with Facebook: \(signOutError)")
            
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
