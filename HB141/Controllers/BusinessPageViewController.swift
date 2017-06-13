//
//  BusinessPageViewController.swift
//  HB141
//
//  Created by Tyler Abney on 2/15/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class BusinessPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageController : UIPageViewController!
    var navController : UINavigationController?
    var changeMap : MapViewChangeProtocol?
    
    var businesses : [Business] = []
    
    var currentIndex : Int?
    var pendingIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        view.addSubview(pageController.view)
        
        view.bringSubview(toFront: pageControl)
    }
    
    func setBusinesses(newBusinesses : [Business]) {
        self.businesses = newBusinesses
        
        pageController.setViewControllers([getViewController(atIndex: 0)], direction: .forward, animated: true, completion: nil)
        
        changeMap?.moveMap(to: businesses[0].location!)
        
        pageControl.numberOfPages = businesses.count
        pageControl.currentPage = 0
    }
    
    func getViewController(atIndex index: Int) -> BusinessViewController {
        let businessViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessViewControllerID") as! BusinessViewController
        
        businessViewController.business = businesses[index]
        businessViewController.index = index
        businessViewController.navController = self.navController
        
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
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let controller = pendingViewControllers.first as! BusinessViewController
        pendingIndex = businesses.index(of: controller.business!)
        changeMap?.moveMap(to: (controller.business?.location)!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
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
