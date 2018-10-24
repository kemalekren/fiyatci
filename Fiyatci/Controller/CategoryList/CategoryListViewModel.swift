//
//  CategoryListViewModel.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import Foundation
import CoreData

protocol CategoryListViewModelDelegate: AnyObject {
    func dataDidChange()
    func dataWillChange()
    func inserDataTo(indexPath: IndexPath)
    func removeDataAt(indexPath: IndexPath)
}

final class CategoryListViewModel: ViewModel<Category>, NSFetchedResultsControllerDelegate {
    
    weak var delegate: CategoryListViewModelDelegate?
    
    func getNumberOfRows() -> Int {
        guard isFetchResultsControllerAvailable else { return 0 }
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func getObjectAt(indexPath: IndexPath) -> Category {
        return fetchResultsController.object(at: indexPath)
    }
    
    func delete(category: Category) {
        guard isFetchResultsControllerAvailable else { return }
        context.delete(category)
    }
    
    override var sortDescriptor: NSSortDescriptor {
        return NSSortDescriptor(key: "\(#keyPath(Category.name))", ascending: true)
    }
    
    override func setupFetchResultsControllerDelegate() -> NSFetchedResultsControllerDelegate? {
        return self
    }
    
    
    // MARK: -
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataDidChange()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataWillChange()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                delegate?.inserDataTo(indexPath: newIndexPath)
            }
        case .delete:
            if let indexPath = indexPath {
                delegate?.removeDataAt(indexPath: indexPath)
            }
        default:
            break
        }
    }
}
