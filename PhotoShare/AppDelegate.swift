//
//  AppDelegate.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 3.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        startWithLoginFlow()
        
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled: Bool = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return handled
    }
    
    private func startWithLoginFlow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginViewController = LoginVC()
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
    }
}

