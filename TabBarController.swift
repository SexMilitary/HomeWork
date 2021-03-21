//
//  TabBarController.swift
//  LifeCycleVC
//
//  Created by Максим on 19.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        tabBar.barTintColor = .systemGroupedBackground
        tabBar.tintColor = .systemTeal
        
        setupVCs()
    }
    
    func setupVCs() {
        
        viewControllers = [
            
            createNavController(for: RequestViewController(),
                                prefersLargeTitles: true,
                                title: NSLocalizedString("URLRequests", comment: ""),
                                image: UIImage(systemName: "paperplane")!),
            
            createNavController(for: NetworkViewController(),
                                prefersLargeTitles: true,
                                title: NSLocalizedString("Network", comment: ""),
                                image: UIImage(systemName: "network")!),
            
            createNavController(for: MainViewController(),
                                prefersLargeTitles: false,
                                title: NSLocalizedString("MainView", comment: ""),
                                image: UIImage(systemName: "list.bullet.below.rectangle")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         prefersLargeTitles: Bool,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = prefersLargeTitles
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
