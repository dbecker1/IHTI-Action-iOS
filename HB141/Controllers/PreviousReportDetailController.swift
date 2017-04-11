//
//  PreviousReportDetailController.swift
//  HB141
//
//  Created by Binit Shah & Emma Flynn on 4/10/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class PreviousReportDetailController: UIViewController {
    // This variable will hold the data being passed from the First View Controller
    var location: String! = "";
    var datetime: String! = "";
    var address: String! = "";
    var noview: String! = "";
    var publicview: String! = "";
    var restroomview: String! = "";
    var comment: String! = "";
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = "\(location!)";
        datetimeLabel.text = "\(datetime!)";
        addressLabel.text = "\(address!)";
        commentLabel.text = "\(comment!)";
        
        if (noview == "true") {
            viewLabel.text = "Not Posted."
        } else if (publicview == "true" && restroomview == "true") {
            viewLabel.text = "Public View and Restroom View."
        } else if (publicview == "true") {
            viewLabel.text = "Public View."
        } else if (restroomview == "true") {
            viewLabel.text = "Restroom View."
        } else {
            viewLabel.text = ""
        }
    }
}
