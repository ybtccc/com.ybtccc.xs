//
//  AppDelegate.swift
//  demo4
//
//  Created by ybtccc on 2018/12/16.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // 首页
        let home = UIStoryboard(name: "First",bundle: nil).instantiateInitialViewController()
        let second = UIStoryboard(name: "Second",bundle: nil).instantiateInitialViewController()
        
        let homeNc = UINavigationController(rootViewController: home!)
        let bgColor = UIColor(red: 237/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1)
        homeNc.navigationBar.barTintColor = bgColor
        homeNc.navigationBar.tintColor = UIColor.white
        homeNc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        homeNc.tabBarItem.title = "追书"
        homeNc.tabBarItem.image = UIImage(named: "home")
        
        let secondNc = UINavigationController(rootViewController: second!)
        secondNc.navigationBar.barTintColor = bgColor
        secondNc.navigationBar.tintColor = UIColor.white
        secondNc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        secondNc.tabBarItem.title = "排行"
        secondNc.tabBarItem.image = UIImage(named: "sort")
        
        let controllers = [homeNc,secondNc]
        let mainController = UITabBarController()
        mainController.viewControllers = controllers
        mainController.tabBar.tintColor = bgColor
        self.window?.rootViewController = mainController
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

