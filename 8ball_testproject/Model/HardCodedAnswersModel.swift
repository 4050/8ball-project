//
//  HardCodedAnswersModel.swift
//  8ball_testproject
//
//  Created by Станислав on 18/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class HardCodedAnswerModel {

    private let persistentService: PersinstenServise

    init(persistentService: PersinstenServise) {
        self.persistentService = persistentService
    }

    func getSaveAnswer() -> Answer {
        let answer = persistentService.getSaveAnswer()
        return answer
    }

    func saveIndex(index: Int) {
        persistentService.saveIndexAnswer(index: index)
    }

    func getMotivationAnswers() -> [PresentableAnswer] {
        let answers = persistentService.getMotivationAnswers()
        let presentableAnswers = answers.map { $0.toPresentableAnswer() }
        return presentableAnswers
    }
}
