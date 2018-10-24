//
//  AppCoordinator.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private var childCoordinators = [ChildCoordinator]()
    private let dataManager: CoreDataManager = CoreDataManager(modelName: "Fiyatci")
    
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        dataManager.load { (error) in
            guard error == nil else { fatalError("Can not load data manager") }
            self.childCoordinators = self.generateCoordinators()
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = self.generateCoordinators().compactMap{
                $0.start()
                self.childCoordinators.append($0)
                return $0.getTopVC()
            }
            
            self.window.rootViewController = tabBarController
        }
    }
    
    private func generateCoordinators() -> [ChildCoordinator] {
        let navigationController: UINavigationController = {
            let navController = UINavigationController()
            navController.tabBarItem = UITabBarItem(title: "Category", image: nil, selectedImage: nil)
            
            return navController
        }()
        let categoryCoordinator = CategoryCoordinator(navigationController: navigationController, dataManager: dataManager)
        
        let basketCoordinator = BasketCoordinator(dataManager: dataManager)
        
        return [
            categoryCoordinator,
            basketCoordinator
        ]
    }
}
