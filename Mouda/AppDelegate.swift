/*
 TODO
 1. iCloud에 어떻게 저장하는 지 알아보기
 2. 설정 탭 내용
 3. 북마크 테이블 뷰
 4. 책 검색
 5. 아이콘 화질 ---> 코딘 ??????? :)

 하면 좋은것
 1. AddVC 모달 띄우기
 
 */

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
        // Override point for customization after application launch.
        
        // 네비게이션 바 색상
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 82/255, green: 62/255, blue: 53/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        let myFeedsVC = FeedTableVC()
        let myFeedNavContr = UINavigationController(rootViewController: myFeedsVC)
        myFeedNavContr.tabBarItem = UITabBarItem(title: "보이다", image: #imageLiteral(resourceName: "Home"), tag: 0)
        
        let addVC = AddFeedVC()
        let addNavContr = UINavigationController(rootViewController: addVC)
        addNavContr.tabBarItem = UITabBarItem(title: "쓰다", image: #imageLiteral(resourceName: "Add"), tag: 1)
        
        let layout = UICollectionViewFlowLayout()
        let bookmarkVC = BookmarkCollectionVC(collectionViewLayout: layout)
        let bookmarkNavContr = UINavigationController(rootViewController: bookmarkVC)
        bookmarkNavContr.tabBarItem = UITabBarItem(title: "남기다", image: #imageLiteral(resourceName: "Bookmark"), tag: 2)
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [myFeedNavContr, addNavContr, bookmarkNavContr]
        tabBarController.tabBar.tintColor = .tabBarTintColor
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        dataCenter.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        dataCenter.save()
    }


}
