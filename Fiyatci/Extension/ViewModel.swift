//
//  ViewModel.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import Foundation
import CoreData


class ViewModel<T: NSManagedObject>: NSObject{
    private(set) var dataManager: CoreDataManager

    var fetchResultsController: NSFetchedResultsController<T>!
    
    var isFetchResultsControllerAvailable: Bool {
        return fetchResultsController != nil
    }
    
    var predicate: NSPredicate? {
        return nil
    }
    
    
    var context: NSManagedObjectContext {
        return dataManager.viewContext
    }
    
    var sortDescriptor: NSSortDescriptor {
        return NSSortDescriptor()
    }
    
    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
        super.init()
        fetchResultsController = setupFetchResultsController()
        fetchResultsController.delegate = setupFetchResultsControllerDelegate()
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("\(error): \(error.localizedDescription)")
        }
    }
    
    deinit {
        fetchResultsController = nil
    }
    
    func setupFetchResultsController() -> NSFetchedResultsController<T>  {
        let controller: NSFetchedResultsController<T> = {
            let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
            fetchRequest.sortDescriptors = [ sortDescriptor ]
            fetchRequest.predicate = predicate
            
            let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
             return controller
        }()
        
        return controller
    }
    
    func setupFetchResultsControllerDelegate() -> NSFetchedResultsControllerDelegate? {
        return nil
    }
    
    
}
