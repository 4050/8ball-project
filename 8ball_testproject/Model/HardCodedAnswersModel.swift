//
//  HardCodedAnswersModel.swift
//  8ball_testproject
//
//  Created by Станислав on 18/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import RxSwift

class HardCodedAnswerModel {

    private let storageAnswer: PersistenceStore
    public let answer = BehaviorSubject<[Answer?]>(value: [nil])
    public let customAnswer = PublishSubject<Answer?>()
    public let savedCustomAnswer = PublishSubject<Answer?>()

    init( storageAnswer: PersistenceStore) {
        self.storageAnswer = storageAnswer
    }

    func getSavedAnswer() -> Answer {
        let storage = storageAnswer.getMotivationAnswers()
        let number = Int.random(in: 0 ..< storage.count)
        let answer = storage[number]
        return answer
    }

    func requestData() {
        let answers = storageAnswer.getMotivationAnswers()
        //let presentableAnswers = answers.map { $0.toPresentableAnswer() }
        self.answer.onNext(answers)
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
