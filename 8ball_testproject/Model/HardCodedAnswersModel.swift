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

    func getSaveAnswer(completion: @escaping (Answer) -> Void) {
        persistentService.getSaveAnswer { storedAnswer in
            completion(storedAnswer) }
    }

    func sendIndex(index: Int) {
        persistentService.sendIndexAnswer(index: index)
    }

    func sendMotivationAnswers() -> [PresentableAnswer] {
        let answers = persistentService.sendMotivationAnswers()
        let presentableAnswers = answers.map { $0.toPresentableAnswer() }
        return presentableAnswers
    }
}
