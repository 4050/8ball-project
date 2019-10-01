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
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        if let mainViewController = storyboard.instantiateViewController(
                            withIdentifier: "MainViewController") as?  MainViewController {

                        let networkService = NetworkService()
                        let hardCodedAnswerModel = HardCodedAnswersModel()
                        let hardCodedAnswerViewModel =
                            HardCodedAnswersViewModel(hardCodedAnswersModel: hardCodedAnswerModel)
                        let networkDataFetcher = NetworkDataFetcher(networkService: networkService)
                        let responseModel = ResponseModel(networkDataFetch: networkDataFetcher,
                                                          hardCodedAnswerModel: hardCodedAnswerModel)
                        let responseViewModel = ResponseViewModel(responseModel: responseModel)
                        mainViewController.setMainViewModel(responseViewModel)
                        let pickerView = PickerViewController()
                        pickerView.setPickerViewModel(hardCodedAnswerViewModel)
                        navigationController =
                                UINavigationController.init(rootViewController: mainViewController)
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()

                        }
        return true
    }
}
