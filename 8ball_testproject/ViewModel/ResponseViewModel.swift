//
//  ResponseViewModel.swift
//  8ball_testproject
//
//  Created by Станислав on 29/09/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation

class ResponseViewModel {

    private let responseModel: ResponseModel!

    init(responseModel: ResponseModel) {
        self.responseModel = responseModel
    }

    func getData(completion: @escaping (PresentableAnswer?) -> Void) {
        responseModel.getAnswer { (answer) in
                completion(answer)
        }
    }
}
