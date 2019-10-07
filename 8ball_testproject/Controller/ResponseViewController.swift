//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {

    private var responseViewModel: ResponseViewModel!

    func setViewModel(_ viewModel: ResponseViewModel) {
        self.responseViewModel = viewModel
    }

    //IBOutlets
    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = Asset.magicEightBall.image
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Method Shake Gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            responseViewModel.getData { answer in
                        DispatchQueue.main.async {
                            self.answerLabel.text = answer?.answer
                }
            }
        }
    }

    @IBAction private func settingJump(for segue: UIStoryboardSegue, sender: Any?) {
        self.performSegue(withIdentifier: "PickerViewController", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier  == "PickerViewController" {
            let hardCodedAnswerViewModel = HardCodedAnswersViewController()
            pickerView.setPickerModel(hardCodedAnswerViewModel)

            if let viewController = segue.destination as? HardCodedAnswersViewController {
                viewController.setPickerModel(hardCodedAnswerViewModel)
            }
        }
    }
}
