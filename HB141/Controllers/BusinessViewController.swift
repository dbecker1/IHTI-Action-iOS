//
//  BusinessViewController.swift
//  HB141
//
//  Created by Tyler Abney on 2/15/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var index: Int = 0
    
    var business : Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = business?.businessName
        typeLabel.text = business?.businessType
        imageView.image = business?.image

        imageView.isUserInteractionEnabled = true
        let singletap = UITapGestureRecognizer(target: self, action: #selector(showReport))
        imageView.addGestureRecognizer(singletap)
        
        // Do any additional setup after loading the view.
    }
    
    func showReport() {
        performSegue(withIdentifier: "enterReport", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterReport" {
            let reportController = segue.destination as! ReportViewController
            reportController.business = business
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
