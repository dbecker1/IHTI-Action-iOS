//
//  BaseNavigationController.swift
//  HB141
//
//  Created by Daniel Becker on 3/8/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.barTintColor = ColorConstants.titleBarColor
        self.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setBackButton() -> Void {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    static func getMenuButton() -> UIBarButtonItem {
        let menuButton = UIBarButtonItem(title: String.fontAwesomeIcon(name: .bars), style: .plain, target: self, action: #selector(menuButtonClicked))
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20), NSForegroundColorAttributeName: UIColor.white] as [String: Any]
        menuButton.setTitleTextAttributes(attributes, for: .normal)
        return menuButton
    }
    
    static func getBackButton() -> UIBarButtonItem {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        let attributes = [NSForegroundColorAttributeName: UIColor.white] as [String: Any]
        backButton.setTitleTextAttributes(attributes, for: .normal)
        return backButton
    }
    
    static func menuButtonClicked() -> Void {
        print("clicked")
    }
    
    func setMenuButton() -> Void {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\u{f0c9}", style: .plain, target: nil, action: nil)
    }
}
