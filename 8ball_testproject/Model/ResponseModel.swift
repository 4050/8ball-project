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

    init(networkDataFetch: NetworkDataFetcher, hardCodedAnswerModel: HardCodedAnswerModel) {
        self.networkDataFetch = networkDataFetch
        self.hardCodedAnswerModel = hardCodedAnswerModel
    }

    func getAnswer(completion: @escaping (PresentableAnswer?) -> Void) {
        networkDataFetch.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (response, error) in
            let responseAnswer = response?.toPresentableAnswer()

            if error != nil {
                let answer = self.hardCodedAnswerModel.getSaveAnswer()
                let responseAnswer = answer.toPresentableAnswer()
                completion(responseAnswer)
            } else {
                completion(responseAnswer)
            }
        }
    }
}
