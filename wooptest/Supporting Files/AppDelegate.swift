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
        
        setNavigationBarColor()
        initMainScreen()
        return true
    }
    
    private func setNavigationBarColor() {
        let mainColor = UIColor(red: 23/255, green: 230/255, blue: 119/255, alpha: 1)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = mainColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = mainColor
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
    private func initMainScreen() {
        let vc = WPEventsRouter().build()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}
