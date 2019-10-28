//
//  ResponseViewModel.swift
//  8ball_testproject
//
//  Created by Станислав on 29/09/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import RxSwift

class ResponseViewModel {

    private let responseModel: ResponseModel!
    private let disposeBag = DisposeBag()
    let shakeAction = PublishSubject<Void>()
    var loading: Observable<Bool> {
        return responseModel.loading.asObservable()
    }

    var answerStream: Observable<String?> {
        return responseModel.answer.asObservable()
            .filter { $0 != nil }
            .map { answer -> String? in
                return answer?.toPresentableAnswer().answer
            }
        }

    init(responseModel: ResponseModel) {
        self.responseModel = responseModel
        setupBindigns()
    }

    private func setupBindigns() {
        shakeAction.subscribe(onNext: { [weak self] in
            self?.requestData()
            }).disposed(by: disposeBag)
    }

    private func requestData() {
        responseModel.requestData()
    }
}
