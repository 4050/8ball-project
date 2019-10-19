//
//  ManagedAnswer+CoreDataProperties.swift
//  
//
//  Created by Станислав on 19/10/2019.
//
//

import Foundation
import CoreData

extension ManagedAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedAnswer> {
        return NSFetchRequest<ManagedAnswer>(entityName: "ManagedAnswer")
    }

    func toAnswer() -> Answer {
        return Answer(answer: answer)
    }

    @NSManaged public var answer: String?
    @NSManaged public var date: NSDate?

}
