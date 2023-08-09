//
//  TabBarController.swift
//  Connect
//
//  Created by Andrew Koo on 8/9/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Home View Controller
        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        
        // Search View Controller
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        // Create View Controller
        let createViewController = UIViewController()
        createViewController.title = "Create"
        createViewController.tabBarItem.image = UIImage(systemName: "plus.circle")
        
        // Account View Controller
        let accountViewController = UIViewController()
        accountViewController.title = "Account"
        accountViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        
        // Feedback View Controller
        let feedbackViewController = UIViewController()
        feedbackViewController.title = "Feedback"
        feedbackViewController.tabBarItem.image = UIImage(systemName: "bell")
        
        let controllers = [homeViewController, searchViewController, createViewController, accountViewController, feedbackViewController]
        

        let navigationControllerArray = controllers.map { controller -> UINavigationController in
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.navigationBar.topItem?.title = ""
            return navigationController
        }

        self.viewControllers = navigationControllerArray
        
        tabBar.tintColor = .systemBlue
        
        
    }
}

