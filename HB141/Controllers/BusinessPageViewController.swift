//
//  BusinessPageViewController.swift
//  HB141
//
//  Created by Tyler Abney on 2/15/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class BusinessPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var all_business_array : [Business?] = []
    var to_display_business_array : [BusinessViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        fill_array_test()
        
        to_display_business_array =  create_business_cards(array: all_business_array)
        var first : [BusinessViewController] = []
        first.append(to_display_business_array[0])
        setViewControllers(first, direction: UIPageViewControllerNavigationDirection.forward, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create_business_cards(array: [Business?]) -> [BusinessViewController] {
        let story = UIStoryboard(name: "Map", bundle: nil)
        var ret_array : [BusinessViewController] = []
        
        for i in 0...4 {
            if all_business_array[i] != nil {
                let bvc = story.instantiateViewController(withIdentifier: "BusinessViewControllerID") as! BusinessViewController
                bvc.temp_name = (array[i]?.businessName)!
                bvc.temp_type = (array[i]?.businessType)!
                bvc.temp_image = array[i]?.image
                ret_array.append(bvc)
            }
        }
        return ret_array
    }
    
    func fill_array_test() {
        
        for _ in 0...4 {
            let new = Business()
            new.businessName = "fake name"
            new.businessType = "fake type"
            new.image = UIImage(named: "house.png")
            all_business_array.append(new)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("AFTER PAGE\n")
        let index = to_display_business_array.index(of: viewController as! BusinessViewController)!
        if index == 4 {
            return nil
        } else {
            return to_display_business_array[index+1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("BEFORE PAGE\n")
        let index = to_display_business_array.index(of: viewController as! BusinessViewController)!
        if index == 0 {
            return nil
        } else {
            return to_display_business_array[index-1]
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
