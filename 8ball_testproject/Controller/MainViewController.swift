//
//  ViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit
import CoreData


class MainViewController: UIViewController {
    
    //Constants
    let ANSWER_URL = "https://8ball.delegator.com/magic/JSON/question"
    
    //IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Method Shake Gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        getQuestionResponse()
    }
    
    // MARK: - JSON Parsing
   fileprivate func getQuestionResponse() {
       guard let url = URL(string: ANSWER_URL) else { return }
    
       URLSession.shared.dataTask(with: url) { (data, response, err) in
       if let err = err {
               print("Failed to get data from URL: ", err)
                    self.answerLabel.text = UserDefaults.standard.string(forKey: "answer")
           }
       guard let data = data else { return }
            do { //response JSON
                let decodeAnswer = try JSONDecoder().decode(Magic.self, from: data)
                    DispatchQueue.main.async {
                       self.answerLabel.text = decodeAnswer.magic.answer
                    }
               } catch let jsonErr {
                            print(jsonErr)
            }
       }.resume()
    }
}
