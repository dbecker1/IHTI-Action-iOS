//
//  AppDelegate.swift
//  HB141
//
//  Created by Daniel Becker on 2/5/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FirebaseDatabase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        var googleInfoFilePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        
        if (SystemConstants.debug) {
            googleInfoFilePath = Bundle.main.path(forResource: "GoogleService-Info_dev", ofType: "plist")
        }
        
        let options = FIROptions(contentsOfFile: googleInfoFilePath)
        FIRApp.configure(with: options!)
        
        GMSServices.provideAPIKey(GoogleConstants.mapsApiKey)
        
        GMSPlacesClient.provideAPIKey(GoogleConstants.placesApiKey)
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        var storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if FIRAuth.auth()?.currentUser != nil {
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        
        let initialViewController = storyboard.instantiateInitialViewController()
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let googleHandled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        
        let facebookHandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return googleHandled || facebookHandled
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let googleHandled = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        
        let facebookHandled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return googleHandled || facebookHandled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

