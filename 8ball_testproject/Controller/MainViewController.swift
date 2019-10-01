//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  private var responseViewModel: ResponseViewModel!


    func setMainViewModel(_ viewModel: ResponseViewModel) {
        self.responseViewModel = viewModel
    }

    //IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
        imageView.image = Asset.magicEightBall.image
    }

    // MARK: - Method Shake Gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shakettru")
            responseViewModel.getData(completion: { answer in
                DispatchQueue.main.async {
                    self.answerLabel.text = answer
                }
            })
        }
    }
}
