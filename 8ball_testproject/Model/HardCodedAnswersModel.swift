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
    private let disposeBag = DisposeBag()
    public let answer = BehaviorSubject<[Answer?]>(value: [nil])
    public let savedCustomAnswer = PublishSubject<Answer?>()

    init( storageAnswer: PersistenceStore) {
        self.storageAnswer = storageAnswer
        setupBindigns()
    }

    func setupBindigns() {
        savedCustomAnswer
            .bind { [weak self ] answer in
                guard let answer = answer else { return }
                self?.storageAnswer.saveAnswer(answer: answer)
            }.disposed(by: disposeBag)
    }

    func getSavedAnswer() -> Answer {
        let storage = storageAnswer.getMotivationAnswers()
        let number = Int.random(in: 0 ..< storage.count)
        let answer = storage[number]
        return answer
    }

    func requestData() {
        let answers = storageAnswer.getMotivationAnswers()
        self.answer.onNext(answers)
    }
}
