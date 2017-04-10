//
//  SettingsTableViewController.swift
//  HB141
//
//  Created by Tyler Abney on 4/9/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase


class SettingsTableViewController: UITableViewController {
    

    @IBOutlet weak var user_name: UIButton!
    @IBOutlet weak var user_email: UIButton!
    @IBOutlet weak var hasFaceBookCheckmark: UIImageView!
    @IBOutlet weak var hasGoogleCheckmark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        displayInfo()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return 3
        } else if (section == 1) {
            return 1
        } else if (section == 2) {
            return 3
        } else {
            return 0
        }
    }
    
    func displayInfo() {
        user_name.setTitle(FIRAuth.auth()!.currentUser!.displayName, for: .normal)
        user_email.setTitle(FIRAuth.auth()!.currentUser!.email, for: .normal)
        if (!AuthManager.shared.userHasFacebook()) {
            hasFaceBookCheckmark.isHidden = true
        }
        if (!AuthManager.shared.userHasGoogle()) {
            hasGoogleCheckmark.isHidden = true
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "setName" ) {
            let dest = segue.destination as! SetNameViewController
            dest.name = user_name.currentTitle
            dest.type = "name"
        } else if (segue.identifier == "setEmail") {
            let dest = segue.destination as! SetNameViewController
            dest.name = user_email.currentTitle
            dest.type = "email"
        } else if (segue.identifier == "setPass") {
            let dest = segue.destination as! SetNameViewController
            dest.type = "pass"
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue){
        let source = segue.source as! SetNameViewController
        if (source.type == "name") {
            user_name.setTitle(source.name, for: .normal)
        }
        print("SOURCE TYPE +++++++++++++++++")
        print(source.type!)
        print("SOURCE NAME +++++++++++++++++")
        print(source.name!)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
