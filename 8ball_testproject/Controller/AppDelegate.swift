//
//  AppDelegate.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let storageService = StorageAnswerService()
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {

            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UINavigationController(rootViewController: TabViewController())
            window?.makeKeyAndVisible()

            return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        storageService.saveContex()
    }
}
