//
//  ManageAnswer+CoreDataProperties.swift
//  
//
//  Created by Станислав on 16/10/2019.
//
//

import Foundation
import CoreData

extension ManageAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManageAnswer> {
        return NSFetchRequest<ManageAnswer>(entityName: "ManageAnswer")
    }

    func toAnswer() -> Answer {
        return Answer(answer: answer)
    }

    @NSManaged public var answer: String?
    @NSManaged public var date: NSDate?

}
