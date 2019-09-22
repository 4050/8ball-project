//
//  Network.swift
//  8ball_testproject
//
//  Created by Станислав on 31/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class Network {

    let answerURL = "https://8ball.delegator.com/magic/JSON/question"

    func getQuestionResponse() {
        guard let url = URL(string: answerURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to get data from URL: ", err)
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
