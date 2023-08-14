//
//  TabBarController.swift
//  Connect
//
//  Created by Andrew Koo on 8/9/23.
//

import UIKit

class TabBarController: UITabBarController, TabBarDelegate, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        homeViewController.tabBarDelegate = self
        homeViewController.tabBarItem.image = UIImage(systemName: "house")

        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarDelegate = self
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        let channelViewController = UIViewController() // Not used directly
        channelViewController.title = "Channel"
        channelViewController.tabBarItem.image = UIImage(systemName: "globe")

        let accountViewController = UIViewController()
        accountViewController.title = "Account"
        accountViewController.tabBarItem.image = UIImage(systemName: "person.circle")

        let feedbackViewController = UIViewController()
        feedbackViewController.title = "Feedback"
        feedbackViewController.tabBarItem.image = UIImage(systemName: "bell")

        let controllers = [homeViewController, searchViewController, channelViewController, accountViewController, feedbackViewController]

        let navigationControllerArray = controllers.map { controller -> UINavigationController in
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.navigationBar.topItem?.title = ""
            return navigationController
        }

        self.viewControllers = navigationControllerArray

        tabBar.tintColor = .systemBlue
    }
    
    func didSelectChannel(_ channel: Channel) {
        let channelViewController = ChannelViewController(channel: channel)
        channelViewController.title = "Channel"
        channelViewController.tabBarItem.image = UIImage(systemName: "globe")

        let navigationController = UINavigationController(rootViewController: channelViewController)
        navigationController.navigationBar.topItem?.title = ""

        // Replace the existing channelViewController in the viewControllers array
        if let index = viewControllers?.firstIndex(where: { $0.title == "Channel" }) {
            viewControllers?[index] = navigationController
            selectedIndex = index  // Update the selected tab index to "Channel"
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Check if the selected view controller is a UINavigationController
        if let navigationController = viewController as? UINavigationController {
            // Check if the root view controller of the selected navigation controller is HomeViewController
            if navigationController.viewControllers.first is HomeViewController {
                // If so, pop to root view controller (HomeViewController)
                navigationController.popToRootViewController(animated: true)
            }
        }

        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is UINavigationController {
            if let navigationController = viewController as? UINavigationController,
               navigationController.viewControllers.first is SearchViewController {
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
}


