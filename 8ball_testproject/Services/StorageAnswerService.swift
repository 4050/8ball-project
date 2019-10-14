//
//  StorageAnswers.swift
//  8ball_testproject
//
//  Created by Станислав on 12/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import CoreData

protocol PersistenceStore {
    func getMotivationAnswers() -> [Answer]
    func saveAnswer(answer: Answer)
}
class StorageAnswerService: PersistenceStore {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StorageAnswers")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    lazy var  backgroundMOC = persistentContainer.newBackgroundContext()
    // MARK: - Core Data Saving support
    func saveContex() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getMotivationAnswers() -> [Answer] {
        context.automaticallyMergesChangesFromParent = true
        let sort = NSSortDescriptor(key: #keyPath(Answers.date), ascending: false)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Answers")
        fetchRequest.sortDescriptors = [sort]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [Answers]
            return (fetchedObjects?.map {$0.toAnswer()})!
        } catch {
            print(error)
            return [Answer]()
        }
    }

    func saveAnswer(answer: Answer) {
        let backgroundMOC = persistentContainer.newBackgroundContext()
        let entity = NSEntityDescription.entity(forEntityName: "Answers", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: backgroundMOC) as! Answers
        let date = NSDate()
        backgroundMOC.performAndWait {
            taskObject.answer = answer.answer
            taskObject.date = date
            try! backgroundMOC.save()
        }
    }
}
