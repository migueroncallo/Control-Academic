//
//  AppDelegate.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 1/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        // [START register_for_notifications]
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            
//            // For iOS 10 data message (sent via FCM)
//            FIRMessaging.messaging().remoteMessageDelegate = self
//            
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//        
//        application.registerForRemoteNotifications()
//        
//        // [END register_for_notifications]
//        FIRApp.configure()
        
       
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if !self.defaults.bool(forKey: "logged"){
            let vc = storyboard.instantiateViewController(withIdentifier: "Departamento VC") as! ViewController
            self.window?.rootViewController = vc
        }else{
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main Menu VC") as! MainMenuController
            let leftViewController = storyboard.instantiateViewController(withIdentifier: "Left Menu VC") as! LeftMenuController
            let nvc = UINavigationController(rootViewController: mainViewController)

            let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
            self.window?.rootViewController = slideMenuController
            self.window?.makeKeyAndVisible()
            DataService.sharedInstance.initData()

        }
        
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

    class func getDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "burger")!)
        
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
}
