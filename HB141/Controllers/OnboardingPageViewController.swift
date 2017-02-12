//
//  OnboardingPageViewController.swift
//  HB141
//
//  Created by Emma Flynn & Binit Shah on 2/11/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newOnboardingViewController(identifier: "WelcomeViewController"),
                self.newOnboardingViewController(identifier: "SummaryViewController"),
                self.newOnboardingViewController(identifier: "EstimatesViewController"),
                self.newOnboardingViewController(identifier: "HowHelpViewController"),
                self.newOnboardingViewController(identifier: "HowWorksViewController")];
    }()
    
    private func newOnboardingViewController(identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Onboarding", bundle: nil);
        let neededViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        return neededViewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataSource = self;
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil;
        }
        
        let previousIndex = viewControllerIndex - 1;
        
        guard previousIndex >= 0 else {
            return nil;
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil;
        }
        
        return orderedViewControllers[previousIndex];
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil;
        }
        
        let nextIndex = viewControllerIndex + 1;
        
        guard nextIndex >= 0 else {
            return nil;
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil;
        }
        
        return orderedViewControllers[nextIndex];
    }
    
}
