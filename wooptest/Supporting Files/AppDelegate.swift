//
//  AppDelegate.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 26/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initMainScreen()
        return true
    }
    
    func initMainScreen() {
        let vc = WPEventsRouter().build()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}

