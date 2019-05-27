//
//  CoreData.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 25/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import CoreData

typealias SaveComplition = (Error?) -> ()
class CoreDataStack {
    var storeURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsURL.appendingPathComponent("mystor.sqlite")
    }
    
    var dataModelName = "Tinkoff________"
    
    var dataModelExtension = "momd"
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modeUrl = Bundle.main.url(forResource: self.dataModelName, withExtension: self.dataModelExtension)!
        return NSManagedObjectModel(contentsOf: modeUrl)!
    }()
    
    
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL, options: nil)
        } catch {
            assert(false, "Error adding store: \(error)")
        }
        
        return coordinator
    }()
    
//    lazy var masterContext: NSManagedObjectContext = {
//        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//
//        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
//        masterContext.mergePolicy = NSOverwriteMergePolicy
//
//        return masterContext
//    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        //mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        
        return mainContext
    }()
    
//    lazy var saveContext: NSManagedObjectContext = {
//        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//
//        saveContext.parent = self.mainContext
//        saveContext.mergePolicy = NSOverwriteMergePolicy
//
//        return saveContext
//    }()
    
    func performSave(with context: NSManagedObjectContext, completion: @escaping ((Error?)->())) {
        guard context.hasChanges else {
            completion(nil)
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch {
                print("Context save error \(error)")
            }
            
//            if let parentContext = context.parent {
//                self.performSave(with: parentContext, completion: completion)
//            } else {
//                completion(nil)
//            }
        }
    }
}


extension DataEntity {
    static func insertData(in context: NSManagedObjectContext) -> DataEntity? {
        guard let data = NSEntityDescription.insertNewObject(forEntityName: "DataEntity", into: context) as? DataEntity else { return nil }
        
        data.clicksAmount = 0
        data.newsId = ""
        
        return data
    }
    
    
    
    static func findOrInsertAppUser(in context : NSManagedObjectContext) -> DataEntity? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("model is not available in context")
            assert(false)
            return nil
        }
        
        var data: DataEntity?
        guard let fetchRequest = DataEntity.fetchRequestAppUser(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple DataEntities Found!")
            if let foundEntity = results.first {
                data = foundEntity
            }
        } catch {
            print("failde to catch AppUser \(error)")
        }
        
        if data == nil {
            data = DataEntity.insertData(in: context)
        }
        
        return data
    }
    
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<DataEntity>? {
        let templateName = "DataEntity"
        
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<DataEntity> else {
            assert(false, "No template with name \(templateName)")
            return nil
        }
        
        return fetchRequest
    }
}

//extension User {
//    func insertUser(in: NSManagedObjectContext) {}
//}

