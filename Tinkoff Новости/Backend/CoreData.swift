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
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        mainContext.mergePolicy = NSOverwriteMergePolicy
        
        return mainContext
    }()
    
    func performSave(with context: NSManagedObjectContext) {
        guard context.hasChanges else {
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch {
                print("Context save error \(error)")
            }
        }
    }
}


extension DataEntity {
    static func insertData(in context: NSManagedObjectContext) -> DataEntity? {
        guard let data = NSEntityDescription.insertNewObject(forEntityName: "DataEntity", into: context) as? DataEntity else { return nil }
        
        data.clicksAmount = 21
        data.newsId = "ewklfds.n"
        
        return data
    }
    
    static func findOrInsertAppUser(in context : NSManagedObjectContext) -> DataEntity? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("model is not available in context")
            assert(false)
            return nil
        }
        var data: DataEntity?
        guard let fetchRequest = DataEntity.fetchRequestDataEntity(model: model) else {
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
    
    
    static func fetchRequestDataEntity(model: NSManagedObjectModel) -> NSFetchRequest<DataEntity>? {
        let templateName = "DataEntity"
        
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<DataEntity> else {
            assert(false, "No template with name \(templateName)")
            return nil
        }
        return fetchRequest
    }
}

func findIDinDB(news: [DataEntity], id: String) -> Int {
    var cnt = 0
    for new in news {
        if new.newsId == id {
            cnt = Int(new.clicksAmount)
        }
    }
    return cnt
}
