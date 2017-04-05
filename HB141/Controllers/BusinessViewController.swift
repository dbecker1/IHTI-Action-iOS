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
    @IBOutlet weak var backgroundView: UIView!
    
    var navController : UINavigationController?

    var index: Int = 0
    
    var business : Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = business?.businessName
        typeLabel.text = business?.businessType
        imageView.image = business?.image

        imageView.isUserInteractionEnabled = true
        let singletap = UITapGestureRecognizer(target: self, action: #selector(showReport))
        self.view.addGestureRecognizer(singletap)
        
        let toView : UIView?
        if (nameLabel.intrinsicContentSize.width > typeLabel.intrinsicContentSize.width) {
            toView = nameLabel
        } else {
            toView = typeLabel
        }
        let constraint = NSLayoutConstraint(item: backgroundView, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1, constant: 10)
        
        view.addConstraint(constraint)
    }
    
    func showReport() {
        let controller = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "ReportID")
        if let reportController = controller as? ReportViewController {
            reportController.business = business
            navController?.pushViewController(reportController, animated: true)
        } else {
            performSegue(withIdentifier: "enterReport", sender: nil)
        }
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
