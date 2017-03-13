//
//  MenuTableViewController.swift
//  HB141
//
//  Created by Daniel Becker on 3/11/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    @IBOutlet weak var locationIcon: UILabel!
    @IBOutlet weak var previousIcon: UILabel!
    @IBOutlet weak var informationIcon: UILabel!
    @IBOutlet weak var settingsIcon: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        locationIcon.font = UIFont.fontAwesome(ofSize: 17)
        locationIcon.text = String.fontAwesomeIcon(name: .mapMarker)
        
        previousIcon.font = UIFont.fontAwesome(ofSize: 17)
        previousIcon.text = String.fontAwesomeIcon(name: .book)
        
        informationIcon.font = UIFont.fontAwesome(ofSize: 17)
        informationIcon.text = String.fontAwesomeIcon(name: .safari)
        
        settingsIcon.font = UIFont.fontAwesome(ofSize: 17)
        settingsIcon.text = String.fontAwesomeIcon(name: .cog)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
