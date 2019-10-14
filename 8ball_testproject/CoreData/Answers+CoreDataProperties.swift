//
//  Answers+CoreDataProperties.swift
//  
//
//  Created by Станислав on 12/10/2019.
//
//

import Foundation
import CoreData

extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers")
    }

    func toAnswer() -> Answer {
        return Answer(answer: answer)
    }

    @NSManaged public var answer: String?
    @NSManaged public var date: NSDate?

}
