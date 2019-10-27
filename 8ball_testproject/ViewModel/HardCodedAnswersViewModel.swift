//
//  HardCodedAnswerViewModel.swift
//  8ball_testproject
//
//  Created by Станислав on 01/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import RxSwift

class HardCodedAnswersViewModel {

    private let hardCodedAnswersModel: HardCodedAnswerModel
    let tapAction = PublishSubject<Void>()
    var customAnswer = PublishSubject<PresentableAnswer>()

    var answerStream: Observable<[String?]> {
        return hardCodedAnswersModel.answer.asObserver()
            .map { answer -> [String?] in
                return answer.map({$0?.toPresentableAnswer().answer})
        }
    }

    init(hardCodedAnswersModel: HardCodedAnswerModel) {
        self.hardCodedAnswersModel = hardCodedAnswersModel
        setupBindigns()
    }

    private func setupBindigns() {
        tapAction.subscribe(onNext: {[weak self] in
            self?.requestData()
        })
    }

    private func requestData() {
        hardCodedAnswersModel.requestData()
    }

    func getMotivationAnswers() -> [PresentableAnswer] {
        let answers = hardCodedAnswersModel.getMotivationAnswers()
        return answers
    }

    func saveCustomAnswer() {
         let answer = customAnswer.asObserver().map({$0.toAnswer().answer})
        //let answers = answer.toAnswer()
        //hardCodedAnswersModel.saveCustomAnswer(answer: answer)
    }
}
