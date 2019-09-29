//
//  PostModel.swift
//  8ball_testproject
//
//  Created by Станислав on 08/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class DataAnswer {

    struct Magic: Codable {
        var magic: Answer
    }

    struct Answer: Codable {
        var answer: String?
    }

    
}
