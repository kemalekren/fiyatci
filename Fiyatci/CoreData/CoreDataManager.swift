//
//  CoreDataManager.swift
//  Virtual Tourist
//
//  Created by Tunc Tugcu on 18.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    typealias CoreDataLoadCompletionHandler = (Error?) -> Void
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
        setupListeners()
    }
    
    private lazy var persistentContainer: NSPersistentContainer = NSPersistentContainer(name: modelName)
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        viewContext.automaticallyMergesChangesFromParent = true
        
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        
        return context
    }()
    
    func load(completion: CoreDataLoadCompletionHandler?) {
        persistentContainer.loadPersistentStores { (description, error) in
            DispatchQueue.main.async { completion?(error) }
        }
    }
    
    private func setupListeners() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: UIApplication.willTerminateNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: UIApplication.willResignActiveNotification, object: self)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func saveChanges(_ notification: Notification) {
        if viewContext.hasChanges {
            viewContext.performAndWait {
                do {
                    try viewContext.save()
                } catch {
                    print("Can not save changes to the disk")
                    print(error.localizedDescription)
                }
            }
        }
        
        if backgroundContext.hasChanges {
            backgroundContext.perform {
                do {
                    try self.backgroundContext.save()
                } catch {
                    print("Can not save shanges in the background context")
                    print(error.localizedDescription)
                }
            }
        }
    }
}
