//
//  MoreInformationViewController.swift
//  HB141
//
//  Created by Daniel Becker on 4/5/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class MoreInformationViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var forward: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "More Information"
        
        setupButtons()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        navigationItem.leftBarButtonItem = BaseNavigationController.getMenuButton()
        navigationItem.backBarButtonItem = BaseNavigationController.getBackButton()
        
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 300
            navigationItem.leftBarButtonItem?.target = self.revealViewController()
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        let url = URL(string: WebConstants.ihtiWebsite)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj);
        
        webView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if activityIndicator != nil && view.subviews.contains(activityIndicator) {
            activityIndicator.removeFromSuperview()
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupButtons() {
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        cancel.title = String.fontAwesomeIcon(name: .times)
        cancel.setTitleTextAttributes(attributes, for: .normal)
        
        refresh.title = String.fontAwesomeIcon(name: .repeat)
        refresh.setTitleTextAttributes(attributes, for: .normal)
        
        back.title = String.fontAwesomeIcon(name: .arrowLeft)
        back.setTitleTextAttributes(attributes, for: .normal)
        
        forward.title = String.fontAwesomeIcon(name: .arrowRight)
        forward.setTitleTextAttributes(attributes, for: .normal)
    }
}
