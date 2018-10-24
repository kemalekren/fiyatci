//
//  ChildCoordinator.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit

protocol ChildCoordinator: Coordinator {
    func getTopVC() -> UIViewController
}
