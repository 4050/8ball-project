//
//  TabViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 14/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        delegate = self
        let storageAnswer = StorageAnswerService()
        let networkService = NetworkService()
        let networkDataFetcher = NetworkDataFetcher(networkService: networkService)
        let hardCodedAnswerModel =
            HardCodedAnswerModel(storageAnswer: storageAnswer)
        let responseModel =
            ResponseModel(networkDataFetch: networkDataFetcher,
                          hardCodedAnswerModel: hardCodedAnswerModel, storageAnswer: storageAnswer)
        let responseViewModel = ResponseViewModel(responseModel: responseModel)
        let hardCodedAnswerViewModel =
            HardCodedAnswersViewModel(hardCodedAnswersModel: hardCodedAnswerModel)

        let firstVC = ResponseViewController(responseViewModel: responseViewModel)
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)

        let secondVC =
            HardCodedAnswersTableViewController(hardCodedAnswerViewModel: hardCodedAnswerViewModel)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)

        let tabViewControllers = [firstVC, secondVC]

        viewControllers = tabViewControllers.map {
            UINavigationController(rootViewController: $0)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        let storageAnswer = StorageAnswerService()
        let hardCodedAnswerModel =
            HardCodedAnswerModel(storageAnswer: storageAnswer)
        let hardCodedAnswerViewModel =
            HardCodedAnswersViewModel(hardCodedAnswersModel: hardCodedAnswerModel)
        let secondVC =
            HardCodedAnswersTableViewController(hardCodedAnswerViewModel: hardCodedAnswerViewModel)

        if tabBarController.selectedIndex == 1 {
            secondVC.viewWillAppear(true)
        }
    }
}
