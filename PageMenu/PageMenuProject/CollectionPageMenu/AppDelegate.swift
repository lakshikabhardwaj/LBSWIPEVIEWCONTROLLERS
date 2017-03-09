//
//  AppDelegate.swift
//  CollectionPageMenu
//
//  Created by lakshika bhardwaj on 20/04/16.
//  Copyright © 2016 Kellton Tech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
      //  let mainViewController = CPPageMenuVC(nibName: "CPPageMenuVC", bundle: nil)
        let mainViewController = CPPageMenuVC(nibName: "CPPageMenuVC", bundle: nil)
       setPageMenu(mainViewController)
        
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func setPageMenu(_ mainVC :CPPageMenuVC) {
  
        mainVC.tabDefaultColor = UIColor(red: 46/255, green: 139/255, blue: 87/255, alpha: 1)
        mainVC.tabSelectedColor = UIColor(red: 46/255, green: 130/255, blue: 87/255, alpha: 1)
        
        let cpCatVC  = CPCatVC(nibName: "CPCatVC", bundle: nil)
        let cowCX = CowVC(nibName: "CowVC", bundle: nil)
              let elephantVC = ElephantVC(nibName: "ElephantVC", bundle: nil)
      
        
        let pageMenuarray :[PageModal] = [PageModal(pageTitle: "Cat", pageVC: cpCatVC),PageModal(pageTitle: "Cow", pageVC: cowCX),PageModal(pageTitle: "Chat", pageVC: cpCatVC),PageModal(pageTitle: "ElephantElephant", pageVC: elephantVC)]
        mainVC.pageArray = pageMenuarray
        
        
    
    }

}

