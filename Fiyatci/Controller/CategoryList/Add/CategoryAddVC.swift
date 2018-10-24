//
//  CategoryAddVC.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit
import CoreData

protocol CategoryAddVCDelegate: AnyObject {
    func categoryVCDone()
}

final class CategoryAddVC: UIViewController {

    weak var delegate: CategoryAddVCDelegate?
    @IBOutlet private weak var textField: UITextField!
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
    }
    
    @objc private func save() {
        if let name = textField.text {
            let category = Category(context: context)
            category.name = name
            category.creationDate = Date()
            do {
                try context.save()
            } catch {
                print("\(error) \(error.localizedDescription)")
            }
        }
        
        
        
        
        delegate?.categoryVCDone()
    }
}
