 //
//  AppDelegate.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let notifSeting=UIUserNotificationSettings(forTypes: .Sound, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notifSeting)
        
        let localNotification=UILocalNotification()
        localNotification.alertTitle="ALERTTTTTTTTTTTT!!!!!!"
        localNotification.alertBody="Fuyez pauvres fou"
        localNotification.fireDate=NSDate.init(timeIntervalSinceNow: NSTimeInterval().advancedBy(10))
        localNotification.soundName=UILocalNotificationDefaultSoundName
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("mise en arrière plan")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("première activation")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("application terminé")
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("J'ai reçut une notification")
    }

}

