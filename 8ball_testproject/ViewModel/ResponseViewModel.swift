//
//  ResponseViewModel.swift
//  8ball_testproject
//
//  Created by Станислав on 29/09/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import UIKit

class ResponseViewModel {

    private let responseModel: ResponseModel!

    init(responseModel: ResponseModel) {
        self.responseModel = responseModel
    }

    func getData(completion: @escaping (PresentableAnswer?) -> Void) {
        responseModel.getAnswer { (answer) in
            completion(answer)
        }
    }
}

extension ResponseViewModel {
    // Думаю еще над пульсацией в центре шара
    func animateTriangleAndText(triangleImage: UIImageView, answerLabel: UILabel) {
        UIView.animate(
            withDuration: 1.5,
            delay: 0.5,
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
                    animations: {
                        triangleImage.transform = .identity
                        answerLabel.transform = .identity
                },
                    completion: nil )
        })
    }
}
