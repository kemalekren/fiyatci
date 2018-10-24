//
//  CategoryCoordinator.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit

final class CategoryCoordinator: ChildCoordinator {
    private let navigationController: UINavigationController
    private let dataManager: CoreDataManager
    
    init(navigationController: UINavigationController, dataManager: CoreDataManager) {
        self.dataManager = dataManager
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CategoryListVC(viewModel: CategoryListViewModel(dataManager: dataManager))
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getTopVC() -> UIViewController {
        return navigationController
    }
}


extension CategoryCoordinator: CategoryListVCDelegate {
    func didTapAddButton() {
        let vc = CategoryAddVC(context: dataManager.viewContext)
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension CategoryCoordinator: CategoryAddVCDelegate {
    func categoryVCDone() {
        navigationController.popViewController(animated: true)
    }
    
    
}
