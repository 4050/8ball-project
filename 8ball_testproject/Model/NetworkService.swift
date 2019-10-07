//
//  Network.swift
//  8ball_testproject
//
//  Created by Станислав on 31/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class NetworkService {

    let answerURL = L10n.URLstring.answerURL

    func getQuestionResponse() {
        guard let answerURL = URL(string: answerURL) else { return }

        URLSession.shared.dataTask(with: answerURL) { (data, _, error) in
            if let error = error {
                print(L10n.Error.failedToGetDataFromURL, error)
                    self.sendingData(data: UserDefaults.standard.string(forKey: "answer")!)
            }
            guard let data = data else { return }
            do {
                 let data = try JSONDecoder().decode(Magic.self, from: data)
                    self.sendingData(data: data.magic.answer!)
                } catch let jsonErr {
                 print(jsonErr)
                     self.sendingData(data: UserDefaults.standard.string(forKey: "answer")!)
            }
        }.resume()
    }

    func sendingData(data: String) {
        NotificationCenter.default.post(name: Notification.Name("didReceiveData"), object: data)
    }

}
