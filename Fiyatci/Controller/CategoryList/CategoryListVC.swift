//
//  CategoryListVC.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit


protocol CategoryListVCDelegate: AnyObject {
    func didTapAddButton()
}

final class CategoryListVC: UIViewController {

    private let reuseId = "askjdlfasdf"
    
    
    weak var delegate: CategoryListVCDelegate?
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: CategoryListViewModel
    init(viewModel: CategoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        viewModel.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func addButtonTapped() {
        delegate?.didTapAddButton()
    }

}

extension CategoryListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) else {
            fatalError("Cell cannot load")
        }
        
        let category = viewModel.getObjectAt(indexPath: indexPath)
        
        cell.textLabel?.text = category.name
        
        return cell
    }
}


extension CategoryListVC: CategoryListViewModelDelegate {
    func removeDataAt(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    func dataDidChange() {
        tableView.endUpdates()
    }
    
    func dataWillChange() {
        tableView.beginUpdates()
    }
    
    func inserDataTo(indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = viewModel.getObjectAt(indexPath: indexPath)
            viewModel.delete(category: category)
        }
    }
}
