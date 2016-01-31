//
//  AppDelegate.swift
//  FeatherweightRouterDemo
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
         didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = appCoordinator()
        window?.makeKeyAndVisible()

        return true
    }

}
