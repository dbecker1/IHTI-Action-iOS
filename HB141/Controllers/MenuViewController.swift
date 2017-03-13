//
//  MenuViewController.swift
//  HB141
//
//  Created by Daniel Becker on 3/11/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import FirebaseAuth

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
