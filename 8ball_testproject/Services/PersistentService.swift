//
//  PersistentService.swift
//  8ball_testproject
//
//  Created by Станислав on 03/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation


// Добрый день, Юрий! Я понял все, что вы мне написали, но слишком поздно и не успел закончить. Отправляю как есть. Не работаю захардкоженные ответы. Готов переделать в ближайшие сроки, но это уже вторая проверка + дедлайе и я все понимаю. Спасибо за знания! Это был лучший опыт!


protocol PersinstenServise {
    func saveAnswerFetch(defaultsAnswer: Int, completion: @escaping (String?) -> Void)
}

struct HardCodedAnswers {

    var motivationAnswers = [ L10n.HardCodedAnswers.yes,
                              L10n.HardCodedAnswers.keepMoving,
                              L10n.HardCodedAnswers.justDoIt,
                              L10n.HardCodedAnswers.changeYourMind ]
}

class PersistentServise: PersinstenServise {
    func saveAnswerFetch(defaultsAnswer: Int, completion: @escaping (String?) -> Void) {
        UserDefaults.standard.set(defaultsAnswer, forKey: "answer")
        let answer = UserDefaults.standard.string(forKey: "answer")!
        completion(answer)
    }
}
