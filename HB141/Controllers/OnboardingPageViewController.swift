//
//  OnboardingPageViewController.swift
//  HB141
//
//  Created by Emma Flynn & Binit Shah on 2/11/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIScrollViewDelegate {
    
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
        
        for subView in view.subviews {
            if subView is UIScrollView {
                (subView as! UIScrollView).delegate = self
            }
        }
        
        self.view.backgroundColor = blendColors(from: UIColor.blue, to: UIColor.red, ratio: 0.5);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        var percentComplete: CGFloat
        percentComplete = (point.x - view.frame.size.width)/view.frame.size.width
        NSLog("percentComplete: %f", percentComplete)
        
    }
    
    func blendColors(from: UIColor, to: UIColor, ratio: CGFloat) -> UIColor {
        let inverseRatio: CGFloat = 1 - ratio;
        var fromRedRaw: CGFloat = 0;
        var fromGreenRaw: CGFloat = 0;
        var fromBlueRaw: CGFloat = 0;
        var toRedRaw: CGFloat = 0;
        var toGreenRaw: CGFloat = 0;
        var toBlueRaw: CGFloat = 0;
        
        if from.getRed(&fromRedRaw, green: &fromGreenRaw, blue: &fromBlueRaw, alpha: nil) && to.getRed(&toRedRaw, green: &toGreenRaw, blue: &toBlueRaw, alpha: nil) {
            let fromRed = fromRedRaw * 255.0;
            let fromGreen = fromGreenRaw * 255.0;
            let fromBlue = fromBlueRaw * 255.0;
            let toRed = toRedRaw * 255.0;
            let toGreen = toGreenRaw * 255.0;
            let toBlue = toBlueRaw * 255.0;
            
            let r: CGFloat = toRed * ratio + fromRed * inverseRatio;
            let g: CGFloat = toGreen * ratio + fromGreen * inverseRatio;
            let b: CGFloat = toBlue * ratio + fromBlue * inverseRatio;
            
            return UIColor(red: r, green: g, blue: b, alpha: 255.0);
        } else {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 255.0);
        }
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
