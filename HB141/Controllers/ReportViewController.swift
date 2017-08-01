//
//  ReportController.swift
//  HB141
//
//  Created by Tyler Abney on 2/23/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase

class ReportViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var report_name: UILabel!
    @IBOutlet weak var report_addr: UILabel!
    
    @IBOutlet weak var comments: UITextField!
    @IBOutlet weak var public_switch: UISwitch!
    @IBOutlet weak var restroom_switch: UISwitch!
    @IBOutlet weak var notposted_switch: UISwitch!
    @IBOutlet weak var submit_label: UIButton!
    
    var business : Business? = nil

    @IBAction func submit_button(_ sender: UIButton) {
        if validateForm() {
            sendReport()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        report_name.text = business?.businessName
        report_addr.text = business?.businessAddress
        
        public_switch.addTarget(self, action: #selector(disableNotPosted), for: UIControlEvents.valueChanged)
        restroom_switch.addTarget(self, action: #selector(disableNotPosted), for: UIControlEvents.valueChanged)
        notposted_switch.addTarget(self, action: #selector(disablePublicAndRestroom), for: UIControlEvents.valueChanged)
        
        self.title = "New Report"

        submit_label.layer.cornerRadius = 2.0
        submit_label.layer.shadowColor = UIColor.black.cgColor
        submit_label.layer.shadowOffset=CGSize(width: 0.5, height: 1)
        submit_label.layer.shadowRadius = 2.0
        submit_label.layer.shadowOpacity = 0.375
        comments.delegate = self
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReportViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReportViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
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
        //Formatting logic is kept at controller level as everything in the model object will be serialized
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GoogleConstants.dateFormat //Your date format
        let dateString = dateFormatter.string(from: Date())
        
        let newReport = Report()
        if comments.text != nil {
            newReport.Comment = comments.text!
        }
        newReport.Datetime = dateString
        newReport.PublicView = public_switch.isOn.description
        newReport.RestroomView = restroom_switch.isOn.description
        newReport.NoView = notposted_switch.isOn.description
        if FIRAuth.auth()?.currentUser?.uid != nil {
            newReport.VID = (FIRAuth.auth()?.currentUser?.uid)!
        }
        if business?.placeID != nil {
            newReport.EID = (business?.placeID!)!
        }
        
        let service = FirebaseService(table: .report)
        let identifier = service.getKey()
        service.enterData(forIdentifier: identifier, data: newReport)
        
        service.table = .establishment
        if let id = business?.placeID {
            service.retrieveData(forIdentifier: id) { (object) in
                if let establishment = object as? Establishment {
                    if establishment.Name == "" {
                        let newEstablishment = Establishment()
                        newEstablishment.Name = (self.business?.businessName ?? "")!
                        newEstablishment.Address = (self.business?.businessAddress ?? "")!
                        newEstablishment.PhoneNumber = (self.business?.businessPhone ?? "")!
                        newEstablishment.Website = (self.business?.businessWebsite ?? "")!
                        service.enterData(forIdentifier: id, data: newEstablishment)
                    }
                }
            }
        }
        
        
        _ = navigationController?.popViewController(animated: true)
        
        
        let prev = navigationController?.viewControllers.last

        if let mapController = prev as? MapViewController {
            mapController.showSuccessfulToast()
        }
        
    }
    
    func validateForm() -> Bool {
        if (!public_switch.isOn && !restroom_switch.isOn && !notposted_switch.isOn) {
            errorLabel.isHidden = false
            return false;
        }
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 64.0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
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
