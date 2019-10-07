//
//  NetworkDataFetcher.swift
//  8ball_testproject
//
//  Created by Станислав on 28/09/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func dataAnswerFetch(urlString: String, completion: @escaping (Answer?, Error?) -> Void)
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

    func dataAnswerFetch(urlString: String, completion: @escaping (Answer?, Error?) -> Void) {

        networkService.request(urlString: urlString) { (data, error) in
            if let error = error {
                print(L10n.Error.errorReceivedRequestingData, error)
                completion(nil, error)
        }
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(Magic.self, from: data)
            let responseAnswer = response?.magic
            let answer = responseAnswer?.toAnswer()

            completion(answer, nil)
        }
    }
}

extension StoregAnswer {
    func toAnswer() -> Answer {
        return Answer(answer: answer)
    }
}
