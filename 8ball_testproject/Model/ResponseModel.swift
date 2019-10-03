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
    private let hardCodedAnswerModel: HardCodedAnswersModel

    init(networkDataFetch: NetworkDataFetcher, hardCodedAnswerModel: HardCodedAnswersModel) {
        self.networkDataFetch = networkDataFetch
        self.hardCodedAnswerModel = hardCodedAnswerModel
    }

    func getAnswer(completion: @escaping (Answer?) -> Void) {
        networkDataFetch.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (response, error) in
            var answer = response.map({$0.toAnswer()})
            //var saveAnswer: String
            if error != nil {
                    //saveAnswer = UserDefaults.standard.string(forKey: "answer")!
                } else {
                    }
                    completion(answer)
                }
            }
        }
