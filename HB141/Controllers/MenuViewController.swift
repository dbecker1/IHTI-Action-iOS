//
//  MenuViewController.swift
//  HB141
//
//  Created by Daniel Becker on 3/11/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var topLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBackground.backgroundColor = ColorConstants.titleBarColor

        // Do any additional setup after loading the view.
        if let user = AuthManager.shared.current() {
            name.text = user.displayName
            email.text = user.email
        }
        
        let backgroundHeight = UIScreen.main.bounds.height * 0.35
        let constraintHeight = (backgroundHeight - 170) / 2
        topLogo.topAnchor.constraint(equalTo: topBackground.topAnchor, constant: constraintHeight).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        AuthManager.shared.logOut() {
            (isSuccessful) -> Void in
            if isSuccessful {
                let onboarding = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!
                self.present(onboarding, animated: true, completion: nil)
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
