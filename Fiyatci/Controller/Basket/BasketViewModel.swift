//
//  BasketViewModel.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import Foundation
import CoreData

final class BasketViewModel: ViewModel<Product>, NSFetchedResultsControllerDelegate {
    override func setupFetchResultsControllerDelegate() -> NSFetchedResultsControllerDelegate? {
        return self
    }
    override var context: NSManagedObjectContext {
        return dataManager.backgroundContext
    }
    
    override var sortDescriptor: NSSortDescriptor {
        return NSSortDescriptor(key: "\(#keyPath(Product.name))", ascending: true)
    }
    
    override var predicate: NSPredicate? {
        return nil
    }
}
