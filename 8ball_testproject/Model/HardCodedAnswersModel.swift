//
//  HardCodedAnswersModel.swift
//  8ball_testproject
//
//  Created by Станислав on 18/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class HardCodedAnswerModel {

    private let storageAnswer: PersistenceStore

    init( storageAnswer: PersistenceStore) {
        self.storageAnswer = storageAnswer
    }

    func getSaveAnswer() -> Answer {
        let storage = storageAnswer.getMotivationAnswers()
        let number = Int.random(in: 0 ..< storage.count)
        let answer = storage[number]
        return answer
    }

    func getMotivationAnswers() -> [PresentableAnswer] {
        let answers = storageAnswer.getMotivationAnswers()
        let presentableAnswers = answers.map { $0.toPresentableAnswer() }
        return presentableAnswers
    }

    func saveCustomAnswer(answer: Answer) {
        storageAnswer.saveAnswer(answer: answer)
    }
}
