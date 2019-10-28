//
//  PostModel.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import RxSwift

class ResponseModel {

    private let networkDataFetch: DataFetcher
    private let hardCodedAnswerModel: HardCodedAnswerModel
    private let storageAnswer: PersistenceStore
    private let disposeBag = DisposeBag()

    public let answer = BehaviorSubject<Answer?>(value: nil)
    public let loading = PublishSubject<Bool>()
    public let shakeAction = PublishSubject<Void>()

    init(networkDataFetch: NetworkDataFetcher,
         hardCodedAnswerModel: HardCodedAnswerModel,
         storageAnswer: StorageAnswerService) {
        self.networkDataFetch = networkDataFetch
        self.hardCodedAnswerModel = hardCodedAnswerModel
        self.storageAnswer = storageAnswer
        setupBindigns()
    }

    private func setupBindigns() {
        shakeAction.subscribe {[weak self] in
            self?.requestData()
        }.disposed(by: disposeBag)
    }

    func requestData() {
        self.loading.onNext(true)
        networkDataFetch.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (response, error) in
        if error != nil {
        let answer = self.hardCodedAnswerModel.getSavedAnswer()
        let response = answer
        self.answer.onNext(response)
        } else {
        self.storageAnswer.saveAnswer(answer: response)
        self.answer.onNext(response)
            }
        }
    }
}
