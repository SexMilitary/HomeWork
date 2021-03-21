//
//  AppDelegate.swift
//  LifeCycleVC
//
//  Created by Максим on 17.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Задержка для LaunchScreen
        Thread.sleep(forTimeInterval: 2.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .darkGray
        let viewcontroller = TabBarController()
        window?.rootViewController = viewcontroller
        window?.makeKeyAndVisible()
        
        return true
    }


}

