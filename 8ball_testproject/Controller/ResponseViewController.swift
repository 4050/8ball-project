//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ResponseViewController: UIViewController {

    private var responseViewModel: ResponseViewModel
    private var shouldAnimate: Bool = true
    private let disposeBag = DisposeBag()

    private let answerLabel: UILabel = {
        let label = UILabel()
        let maxSize = CGSize(width: 150, height: 300)
        let size = label.sizeThatFits(maxSize)
        label.text = L10n.Text.shakeMe
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: size)
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
        imageView.image = Asset._8ballimage.image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let triangleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.triangle.image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
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
        view.backgroundColor = .white
        view.addSubview(ballImage)
        view.addSubview(triangleImage)
        view.addSubview(magicLabel)
        view.addSubview(askLabel)
        view.addSubview(answerLabel)
        setupLayout()
        setupBindings()
    }

    // MARK: - Method Shake Gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.responseViewModel.shakeAction.onNext(())
            // Start Animation
            animateTriangleAndText(triangleImage: triangleImage, answerLabel: answerLabel)
        }
    }

    private func setupBindings() {
        responseViewModel.answerStream.bind(to: answerLabel.rx.text).disposed(by: disposeBag)
        responseViewModel.loading.subscribe(onNext: { [weak self] state in
            self?.shouldAnimate = state
        }).disposed(by: disposeBag)
    }

    private func setupLayout() {
        magicLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        magicLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        magicLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        askLabel.topAnchor.constraint(equalTo: magicLabel.bottomAnchor, constant: 10).isActive = true
        askLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        askLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        answerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        answerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        answerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        ballImage.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        ballImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        ballImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        ballImage.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true

        triangleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 13).isActive = true
        triangleImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        triangleImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        triangleImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
}

extension ResponseViewController {
    func animateTriangleAndText(triangleImage: UIImageView, answerLabel: UILabel) {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                triangleImage.transform =
                    CGAffineTransform( rotationAngle: CGFloat.pi).scaledBy(x: 0.01, y: 0.01)
                answerLabel.transform =
                    CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
        },
            completion: { _ in
                UIView.animate(
                    withDuration: 1.5,
                    delay: 0.5,
                    options: .curveEaseInOut,
                    animations: {
                        triangleImage.transform = .identity
                        answerLabel.transform = .identity
                },
                    completion: { _ in
                        if self.shouldAnimate {
                            self.animateTriangleAndText(triangleImage: triangleImage,
                                                        answerLabel: answerLabel)
                        }
                })
        })
    }
}
