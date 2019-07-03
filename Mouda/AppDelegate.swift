//
//  AppDelegate.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 2..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let myFeedsVC = FeedTableVC()
        let myFeedNavContr = UINavigationController(navigationBarClass: MoudaNavigationBar.self, toolbarClass: nil)
        myFeedNavContr.addChild(myFeedsVC)
        myFeedNavContr.tabBarItem = UITabBarItem(title: "보이다", image: #imageLiteral(resourceName: "Home"), tag: 0)
        
        let addVC = AddFeedVC()
        let addNavContr = UINavigationController(navigationBarClass: MoudaNavigationBar.self, toolbarClass: nil)
        addNavContr.addChild(addVC)
        addNavContr.tabBarItem = UITabBarItem(title: "쓰다", image: #imageLiteral(resourceName: "Add"), tag: 1)
        
        let layout = UICollectionViewFlowLayout()
        let bookmarkVC = BookmarkCollectionVC(collectionViewLayout: layout)
        let bookmarkNavContr = UINavigationController(navigationBarClass: MoudaNavigationBar.self, toolbarClass: nil)
        bookmarkNavContr.addChild(bookmarkVC)
        bookmarkNavContr.tabBarItem = UITabBarItem(title: "남기다", image: #imageLiteral(resourceName: "Bookmark"), tag: 2)
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [myFeedNavContr, addNavContr, bookmarkNavContr]
        tabBarController.tabBar.tintColor = .tabBarTintColor
        
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        dataCenter.save()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        dataCenter.save()
    }


}
