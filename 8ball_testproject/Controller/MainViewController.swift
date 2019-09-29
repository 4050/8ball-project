//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var network: NetworkDataFetcher

    init(network: NetworkDataFetcher) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = Asset.magicEightBall.image
    }

    // MARK: - Method Shake Gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            network.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (answer) in
                DispatchQueue.main.async {
                    self.answerLabel.text = answer?.magic.answer
                }
            }
        }
    }
}
