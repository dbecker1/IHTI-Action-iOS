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
    
    var name : String = ""
    var type: String = ""
    var image: UIImage!
    var index: Int = 0
    var addr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        typeLabel.text = type
        imageView.image = image

        imageView.isUserInteractionEnabled = true
        let singletap = UITapGestureRecognizer(target: self, action: #selector(showReport))
        imageView.addGestureRecognizer(singletap)
        
        // Do any additional setup after loading the view.
    }
    
    func showReport() {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "ReportID") as! ReportController
        newView.preload_name = name
        newView.preload_addr = addr
        self.present(newView, animated: true)
        
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
