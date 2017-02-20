//
//  BusinessPageViewController.swift
//  HB141
//
//  Created by Tyler Abney on 2/15/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class BusinessPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var businesses : [Business] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        //self.setViewControllers([getViewController(atIndex: 0)], direction: .forward, animated: true, completion: nil)
    }
    
    func setBusinesses(newBusinesses : [Business]) {
        self.businesses = newBusinesses
        
        self.setViewControllers([getViewController(atIndex: 0)], direction: .forward, animated: true, completion: nil)
    }
    
    func getViewController(atIndex index: Int) -> BusinessViewController {
        let businessViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessViewControllerID") as! BusinessViewController
        
        businessViewController.name = businesses[index].businessName!
        businessViewController.type = businesses[index].businessType!
        businessViewController.image = businesses[index].image
        businessViewController.index = index
        
        return businessViewController
    }
    
// MARK:- UIPageViewControllerDataSource Implementation
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: BusinessViewController = viewController as! BusinessViewController
        
        var index = pageContent.index
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index -= 1
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: BusinessViewController = viewController as! BusinessViewController
        
        var index = pageContent.index
        
        if (index == NSNotFound) {
            return nil
        }
        
        index += 1
        if (index == businesses.count) {
            return nil
        }
        return getViewController(atIndex: index)
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
