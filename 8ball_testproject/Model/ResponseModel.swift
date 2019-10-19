//
//  PostModel.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class ResponseModel {

    private let networkDataFetch: DataFetcher
    private let hardCodedAnswerModel: HardCodedAnswerModel
    private let storageAnswer: PersistenceStore

    init(networkDataFetch: NetworkDataFetcher,
         hardCodedAnswerModel: HardCodedAnswerModel,
         storageAnswer: StorageAnswerService) {
        self.networkDataFetch = networkDataFetch
        self.hardCodedAnswerModel = hardCodedAnswerModel
        self.storageAnswer = storageAnswer
    }

    func getAnswer(completion: @escaping (PresentableAnswer?) -> Void) {
        networkDataFetch.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (response, error) in
            let responseAnswer = response?.toPresentableAnswer()

            if error != nil {
                let answer = self.hardCodedAnswerModel.getSavedAnswer()
                let responseAnswer = answer.toPresentableAnswer()
                completion(responseAnswer)
            } else {
                self.storageAnswer.saveAnswer(answer: response)
                completion(responseAnswer)
            }
        }
    }
}
