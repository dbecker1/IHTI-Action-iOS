//
//  MoreInformationViewController.swift
//  HB141
//
//  Created by Daniel Becker on 4/5/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class MoreInformationViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "More Information"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        navigationItem.leftBarButtonItem = BaseNavigationController.getMenuButton()
        navigationItem.backBarButtonItem = BaseNavigationController.getBackButton()
        
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 300
            navigationItem.leftBarButtonItem?.target = self.revealViewController()
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        let url = URL(string: "http://theihti.org/")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj);
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
