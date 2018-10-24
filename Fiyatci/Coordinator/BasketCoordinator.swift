//
//  BasketCoordinator.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit

final class BasketCoordinator: ChildCoordinator {
    
    private let vm: BasketViewModel
    
    private lazy var vc = BasketVC(viewModel: vm)
    
    init(dataManager: CoreDataManager) {
        self.vm = BasketViewModel(dataManager: dataManager)
    }
    
    
    func getTopVC() -> UIViewController {
        return vc
    }
    
    func start() {
        vc.tabBarItem = UITabBarItem(title: "Basket", image: nil, selectedImage: nil)
    }
    
    
}
