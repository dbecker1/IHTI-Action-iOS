//
//  SettingsViewController.swift
//  HB141
//
//  Created by Tyler Abney on 3/30/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings";
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        navigationItem.leftBarButtonItem = BaseNavigationController.getMenuButton()
        navigationItem.backBarButtonItem = BaseNavigationController.getBackButton()
        
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 300
            navigationItem.leftBarButtonItem?.target = self.revealViewController()
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
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
