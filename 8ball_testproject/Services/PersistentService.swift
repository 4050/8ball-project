//
//  PersistentService.swift
//  8ball_testproject
//
//  Created by Станислав on 03/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

protocol PersinstenServise {
    func sendMotivationAnswers() -> [Answer]
    func getSaveAnswer(completion: @escaping(Answer) -> Void)
    func sendIndexAnswer(index: Int)

}

struct MotivationAnswer {
    var answers: [String?]
}

struct HardCodedAnswers {
    var answers = [
                    DataAnswer(answer: L10n.HardCodedAnswers.yes),
                    DataAnswer(answer: L10n.HardCodedAnswers.keepMoving),
                    DataAnswer(answer: L10n.HardCodedAnswers.justDoIt),
                    DataAnswer(answer: L10n.HardCodedAnswers.changeYourMind) ]
}

class PersistentServise: PersinstenServise {

    private let hardAnswer = HardCodedAnswers()

    func getSaveAnswer(completion: @escaping (Answer) -> Void) {
        let index = UserDefaults.standard.integer(forKey: "answer")
        let decodeAnswer = hardAnswer.answers[index]
        let storedAnswer = decodeAnswer.toAnswer()
        completion(storedAnswer)
    }

    func sendIndexAnswer(index: Int) {
        UserDefaults.standard.set(index, forKey: "answer")
    }

     func sendMotivationAnswers() -> [Answer] {
        let answers = hardAnswer.answers.map { $0.toAnswer() }
            return answers
    }
}

// extension MotivationAnswer {
//     func toDataAnswer() -> DataAnswer {
//         return DataAnswer(answer: answer)
//     }
// }
