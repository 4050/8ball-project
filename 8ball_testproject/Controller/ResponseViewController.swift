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
    //@IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    private let answerLabel = UILabel()

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.image = Asset.magicEightBall.image
        navigationController?.navigationBar.isHidden = false

        view.backgroundColor = .white

        let magicLabel = UILabel()
        magicLabel.text = "I AM A MAGIC BALL"
        magicLabel.textColor = .black
        magicLabel.textAlignment = .center
        magicLabel.font = UIFont.boldSystemFont(ofSize: 36)
        magicLabel.numberOfLines = 2
        magicLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(magicLabel)
        magicLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        magicLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        magicLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        let askLabel = UILabel()
        askLabel.text = "ASK ME ANYTHING"
        askLabel.textColor = .black
        askLabel.textAlignment = .center
        askLabel.font = UIFont.boldSystemFont(ofSize: 24)
        askLabel.numberOfLines = 2
        askLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(askLabel)
        askLabel.topAnchor.constraint(equalTo: magicLabel.bottomAnchor, constant: 10).isActive = true
        askLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        askLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        answerLabel.text = "shake me!"
        answerLabel.textColor = .black
        answerLabel.textAlignment = .center
        answerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answerLabel)
        answerLabel.topAnchor.constraint(equalTo: askLabel.bottomAnchor, constant: 50).isActive = true
        answerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        answerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector (jump))
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

    @objc func jump() {
            let persisterService = PersistentServise()
            let hardCodedAnswerModel = HardCodedAnswerModel(persistentService: persisterService)
            let hardCodedAnswerViewModel =
              HardCodedAnswersViewModel(hardCodedAnswersModel: hardCodedAnswerModel)
            let pickerView = HardCodedAnswersViewController()
            pickerView.setPickerModel(hardCodedAnswerViewModel)
            self.navigationController?.pushViewController(pickerView, animated: true)

        }

}
