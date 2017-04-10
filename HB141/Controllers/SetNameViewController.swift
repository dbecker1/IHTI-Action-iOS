//
//  SetNameViewController.swift
//  HB141
//
//  Created by Tyler Abney on 4/9/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class SetNameViewController: UIViewController {
    
    var name: String?
    var type: String?
    
    @IBOutlet weak var text_field: UITextField!
    @IBAction func save_name(_ sender: Any) {

        if (type! == "name") {
            AuthManager.shared.updateName(name: text_field.text!, completion: {(result: Bool) -> Void in
                return
            })
        } else if (type! == "email") {
            AuthManager.shared.updateEmail(emailAddress: text_field.text!, completion: {(result: Bool) -> Void in
                return
            })
        } else if (type! == "pass") {
            AuthManager.shared.updatePassword(password: text_field.text!, completion: {(result: Bool) -> Void in
                return
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        text_field.text = name
        if (type == "pass") {
            text_field.isSecureTextEntry = true;
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (type == "name" || type == "email") {
            name = text_field.text!
            print("NEW NAME ++++++++++++")
            print(self.name!)
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
