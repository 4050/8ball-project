//
//  HardCodedAnswerViewModel.swift
//  8ball_testproject
//
//  Created by Станислав on 01/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import UIKit

class HardCodedAnswersViewModel {

    private let hardCodedAnswersModel: HardCodedAnswerModel

    init(hardCodedAnswersModel: HardCodedAnswerModel) {
        self.hardCodedAnswersModel = hardCodedAnswersModel
    }

    func getMotivationAnswers() -> [PresentableAnswer] {
        let answers = hardCodedAnswersModel.getMotivationAnswers()
        print("viewModel\(answers)")
        return answers
    }
}
