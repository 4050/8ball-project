//
//  NetworkService.swift
//  8ball_testproject
//
//  Created by Станислав on 28/09/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class NetworkService {

    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let urlString = URL(string: urlString) else { return }
        let request = URLRequest(url: urlString)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from requst: URLRequest,
                                completion: @escaping (Data?, Error?) -> Void)
        -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
