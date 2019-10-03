//
//  NetworkDataFetcher.swift
//  8ball_testproject
//
//  Created by Станислав on 28/09/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func dataAnswerFetch(urlString: String, completion: @escaping (DataAnswer?, Error?) -> Void)
}

struct Magic: Codable {
    var magic: StoregAnswer
}

struct StoregAnswer: Codable {
    var answer: String?
}

class NetworkDataFetcher: DataFetcher {

    private let networkService: Networking

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func dataAnswerFetch(urlString: String, completion: @escaping (DataAnswer?, Error?) -> Void) {

        networkService.request(urlString: urlString) { (data, error) in
            if let error = error {
                print(L10n.Error.errorReceivedRequestingData, error)
                completion(nil, error)
        }
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(Magic.self, from: data)
            let answer = response?.magic

            let dataAnswer = answer.map {$0.toDataAnswer()}

            completion(dataAnswer, nil)
        }
    }
}

extension StoregAnswer {
    func toDataAnswer() -> DataAnswer {
        return DataAnswer(answer: answer)
    }
}

//func dataAnswerFetch(urlString: String, completion: @escaping (String, Error?) -> Void) {
//
//    networkService.request(urlString: urlString) { (data, error) in
//        if let error = error {
//            let response = "false"
//            print(L10n.Error.errorReceivedRequestingData, error)
//            completion(response, error)
//        }
//
//        let decoder = JSONDecoder()
//        guard let data = data else { return }
//        let response = try? decoder.decode(Magic.self, from: data)
//
//        completion((response?.magic.answer)!, error)
//    }
//}
