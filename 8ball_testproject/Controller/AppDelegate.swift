//
//  AppDelegate.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
                     -> Bool {

                    let navigationController: UINavigationController
                      let persistentService = PersistentServise()
                      let networkService = NetworkService()
                      let networkDataFetcher = NetworkDataFetcher(networkService: networkService)
                      let hardCodedAnswerModel =
                          HardCodedAnswerModel(persistentService: persistentService)
                      let responseModel =
                          ResponseModel(networkDataFetch: networkDataFetcher,
                                        hardCodedAnswerModel: hardCodedAnswerModel)
                      let responseViewModel =
                          ResponseViewModel(responseModel: responseModel)
                        let homeViewController = ResponseViewController()
                      homeViewController.setViewModel(responseViewModel)
                      navigationController =
                              UINavigationController.init(rootViewController: homeViewController)
                          self.window = UIWindow(frame: UIScreen.main.bounds)
                          self.window?.rootViewController = navigationController
                          self.window?.makeKeyAndVisible()
        return true
    }
}
