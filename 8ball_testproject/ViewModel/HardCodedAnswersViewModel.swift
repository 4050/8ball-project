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
    private let disposeBag = DisposeBag()
    let tapAction = PublishSubject<Void>()
    var savedCustomAnswer = PublishSubject<PresentableAnswer?>()

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
        }).disposed(by: disposeBag)

       savedCustomAnswer
            .map {$0?.toAnswer()}
            .bind(to: hardCodedAnswersModel.savedCustomAnswer)
            .disposed(by: disposeBag)
    }

    private func requestData() {
        hardCodedAnswersModel.requestData()
    }
}
