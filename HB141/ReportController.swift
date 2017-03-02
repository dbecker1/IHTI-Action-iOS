//
//  ReportController.swift
//  HB141
//
//  Created by Tyler Abney on 2/23/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class ReportController: UIViewController {

    @IBOutlet weak var report_name: UILabel!
    @IBOutlet weak var report_addr: UILabel!
    
    @IBOutlet weak var public_switch: UISwitch!
    @IBOutlet weak var restroom_switch: UISwitch!
    @IBOutlet weak var notposted_switch: UISwitch!

    @IBAction func submit_button(_ sender: UIButton) {
        sendReport()
    }
    
    
    
    
    var preload_name: String? = "[PLACEHOLDER NAME]"
    var preload_addr: String? = "[PLACEHOLDER ADDR]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        report_name.text = preload_name
        if preload_addr != nil {
            report_addr.text = preload_addr
        }
        
        public_switch.addTarget(self, action: #selector(disableNotPosted), for: UIControlEvents.valueChanged)
        restroom_switch.addTarget(self, action: #selector(disableNotPosted), for: UIControlEvents.valueChanged)
        notposted_switch.addTarget(self, action: #selector(disablePublicAndRestroom), for: UIControlEvents.valueChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disableNotPosted() {
        notposted_switch.setOn(false, animated:true)

    }
    
    func disablePublicAndRestroom() {
        public_switch.setOn(false, animated:true)
        restroom_switch.setOn(false, animated:true)
    }
    
    func sendReport() {
        print("REPORT SENT")
        
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
