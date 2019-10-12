//
//  PersistentService.swift
//  8ball_testproject
//
//  Created by Станислав on 03/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

protocol PersinstenServise {
    func getMotivationAnswers() -> [Answer]
    func getSaveAnswer() -> Answer
    func saveIndexAnswer(index: Int)

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

    func getSaveAnswer() -> Answer {
        let index = UserDefaults.standard.integer(forKey: "answer")
        let decodeAnswer = hardAnswer.answers[index]
        let storedAnswer = decodeAnswer.toAnswer()
        return storedAnswer
    }

    func saveIndexAnswer(index: Int) {
        UserDefaults.standard.set(index, forKey: "answer")
    }

     func getMotivationAnswers() -> [Answer] {
        let answers = hardAnswer.answers.map { $0.toAnswer() }
            return answers
    }
}
