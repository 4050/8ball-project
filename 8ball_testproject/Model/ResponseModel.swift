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

    struct Magic: Codable {
        var magic: Answer
    }

    struct Answer: Codable {
        var answer: String?
    }

    init(networkDataFetch: NetworkDataFetcher, hardCodedAnswerModel: HardCodedAnswersModel) {
        self.networkDataFetch = networkDataFetch
        self.hardCodedAnswerModel = hardCodedAnswerModel
    }

    func getAnswer(completion: @escaping (String?) -> Void) {
        networkDataFetch.dataAnswerFetch(urlString: L10n.URLstring.answerURL) { (response, _) in
            var answer: String = response
            print(answer)
            if answer == "false" {
                    answer = UserDefaults.standard.string(forKey: "answer")!
                    completion(answer)
                } else {
                    completion(answer)
                }
            }
        }
    }
