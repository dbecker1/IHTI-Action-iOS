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
    
    var businessIds : [String] = []
    
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
    
    func setBusinesses(newBusinessIds : [String]) {
        self.businessIds = newBusinessIds
        
        pageController.setViewControllers([getViewController(atIndex: 0)], direction: .forward, animated: true, completion: nil)
        
        let firstBusiness = BusinessProvider.shared.getBusiness(forId: businessIds[0])
        changeMap?.moveMap(to: (firstBusiness?.location!)!)
        
        GooglePlacesService.loadImage(forId: (firstBusiness?.placeID!)!)
        
        pageControl.numberOfPages = businessIds.count
        pageControl.currentPage = 0
    }
    
    func getViewController(atIndex index: Int) -> BusinessViewController {
        let businessViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessViewControllerID") as! BusinessViewController
        
        businessViewController.businessId = businessIds[index]
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
        if (index == businessIds.count) {
            return nil
        }
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let controller = pendingViewControllers.first as! BusinessViewController
        pendingIndex = businessIds.index(of: controller.businessId!)
        
        let business = BusinessProvider.shared.getBusiness(forId: controller.businessId!)
        changeMap?.moveMap(to: (business?.location!)!)
        
        if (controller.imageView.image == nil) {
            GooglePlacesService.loadImage(forId: controller.businessId!)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }

}
