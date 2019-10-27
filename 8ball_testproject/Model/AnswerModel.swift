//
//  AnswerModel.swift
//  8ball_testproject
//
//  Created by Станислав on 03/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import RxSwift

struct Answer {
    var answer: String?
}

extension Answer {
    func toPresentableAnswer() -> PresentableAnswer {
        return PresentableAnswer(answer: answer?.uppercased())
    }
}
