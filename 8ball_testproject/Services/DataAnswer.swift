//
//  DataAnswer.swift
//  8ball_testproject
//
//  Created by Станислав on 03/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

struct DataAnswer {
    var answer: String?
}

extension DataAnswer {
    func toAnswer() -> Answer {
        return Answer(answer: answer)
    }
}
