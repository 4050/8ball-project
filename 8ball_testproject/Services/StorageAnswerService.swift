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
    func saveAnswer(answer: Answer?)
}

class StorageAnswerService: PersistenceStore {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AnswerWarehouse")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    lazy var backgroundMOC = persistentContainer.newBackgroundContext()
    
    // MARK: - Core Data Saving support
    func saveContex() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getMotivationAnswers() -> [Answer] {
        context.automaticallyMergesChangesFromParent = true
        let sort = NSSortDescriptor(key: #keyPath(ManageAnswer.date), ascending: false)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManageAnswer")
        fetchRequest.sortDescriptors = [sort]
        do {
            guard let fetchedObjects =
                try context.fetch(fetchRequest) as? [ManageAnswer] else { return [Answer]() }
            let answers = fetchedObjects.map { $0.toAnswer() }
            return answers
        } catch {
            print(error)
            return [Answer]()
        }
        
    }
    
    func saveAnswer(answer: Answer?) {
        guard let entity =
            NSEntityDescription.entity(forEntityName: "ManageAnswer", in: context) else { return }
        guard let taskObject =
            NSManagedObject(entity: entity, insertInto: backgroundMOC) as? ManageAnswer else {
                return }
        let date = NSDate()
        backgroundMOC.performAndWait {
            taskObject.answer = answer?.answer
            taskObject.date = date
            do {
                try backgroundMOC.save()
            } catch {
                print(error)
            }
        }
    }
}
