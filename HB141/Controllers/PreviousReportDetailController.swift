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
    
    @IBOutlet weak var noviewLabel: UILabel!
    @IBOutlet weak var publicviewLabel: UILabel!
    @IBOutlet weak var restroomviewLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = "\(location!)";
        datetimeLabel.text = "\(datetime!)";
        addressLabel.text = "\(address)";
        commentLabel.text = "\(comment)";
        
        if (noview != "No View") {
            noviewLabel.isHidden = false;
        }
        
        if (publicview != "Public View") {
            publicviewLabel.isHidden = false;
        }
        
        if (restroomview != "Restroom View") {
            restroomviewLabel.isHidden = false;
        }
    }
}
