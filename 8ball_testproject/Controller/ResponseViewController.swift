//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {

    private var responseViewModel: ResponseViewModel

    private let answerLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Text.shakeMe
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let magicLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Text.iAmAMagicBall
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let askLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Text.askMeAnything
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.magicEightBall.image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(responseViewModel: ResponseViewModel) {
        self.responseViewModel = responseViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false

        view.backgroundColor = .white

        view.addSubview(ballImage)
        view.addSubview(magicLabel)
        view.addSubview(askLabel)
        view.addSubview(answerLabel)
        setupLayout()

        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose,
                            target: self,
                            action: #selector (jump))
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
        let hardCodedAnswersViewController = HardCodedAnswersViewController(
            hardCodedAnswerViewModel: hardCodedAnswerViewModel)
        self.navigationController?.pushViewController(hardCodedAnswersViewController, animated: true)
    }

    private func setupLayout() {
        magicLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        magicLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        magicLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        askLabel.topAnchor.constraint(equalTo: magicLabel.bottomAnchor, constant: 10).isActive = true
        askLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        askLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        answerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        answerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        answerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        ballImage.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        ballImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        ballImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        ballImage.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true

    }

}
