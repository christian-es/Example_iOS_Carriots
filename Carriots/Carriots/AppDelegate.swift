//
//  AppDelegate.swift
//  Carriots
//
//  Created by Christian on 18/2/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var option:String = ""
    
    let apikey = "YOUR APIKEY HERE"
    let device = "YOUR DEVICE's ID_DEVELOPER HERE"
    
    enum Shortcut: String {
        case On
        case Off
        case Blink
    }
    
    var shortcutItem: UIApplicationShortcutItem?
    
    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var quickActionHandled = false
        let type = shortcutItem.type.componentsSeparatedByString(".").last!
        if let shortcutType = Shortcut.init(rawValue: type) {
            switch shortcutType {
            case .On:
                option = "ON"
                quickActionHandled = true
            case .Off:
                option = "OFF"
                quickActionHandled = true
            case .Blink:
                option = "BLINK"
                quickActionHandled = true
            }
            
            var data: Dictionary<String, AnyObject>
            
            data = ["value": option]
            
            let carriots = Carriots(api_key: apikey, device: device)
            
            carriots.send_stream(data)
            
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainSB.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            self.window!.rootViewController = vc
            vc.UILabelStatus.text = option
        }
        return quickActionHandled
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        // Handle quick actions
        completionHandler(handleQuickAction(shortcutItem))
    }
}

