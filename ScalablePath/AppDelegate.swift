//
//  AppDelegate.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeConfigurator().resolveViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

