//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var network = NetworkService()

    //IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
            NotificationCenter.default.addObserver(
                                    self, selector: #selector(onDidReceiveData(_:)),
                                    name: Notification.Name("didReceiveData"), object: nil)

        imageView.image = Asset.magicEightBall.image
    }

    // MARK: - Method Shake Gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            network.getQuestionResponse()
        }
    }

    @objc func onDidReceiveData(_ notification: Notification) {
        DispatchQueue.main.async {
            self.answerLabel.text = notification.object as? String
        }
    }

}
