//
//  AppDelegate.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UserInterfaceCheckable {
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setStatusBar()
    setNavigationBar()
    setTabBar()
    return true
  }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return isPad ? .all : .portrait
    }
}


// MARK: - Set style
private extension AppDelegate {
    
    func setStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func setNavigationBar() {
        typealias NavigationBarStyle = Style.NavigationBar
        UINavigationBar.appearance().barTintColor = NavigationBarStyle.backgroundColor
        UINavigationBar.appearance().tintColor = NavigationBarStyle.tintColor
    }
    
    func setTabBar() {
        typealias TabBarStyle = Style.TabBar
        UITabBar.appearance().barTintColor = TabBarStyle.backgroundColor
        UITabBar.appearance().tintColor = TabBarStyle.tintColor
    }
    
}
