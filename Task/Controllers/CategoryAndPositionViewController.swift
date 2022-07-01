//
//  ViewController.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

class CategoryAndPositionViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryTableView: UITableView!

//    var originalData: [Category] = []
//    var arrSearched: [Category] = []
    
    var categoriesViewModel: CategoriesViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.categoryTableViewSetup()
        
        self.fetchCategories()
        
//        self.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
    
    }
    
//    func fetchSearch(originalData: [Category]) {
//        for category in originalData {
//            self.categoryPositionViewModel = CategoryPositionViewModel()
//            self.categoryPositionViewModel?.setCategories(with: [category])
//            self.categoryTableView.reloadData()
//        }
//    }
    
//    @objc func search() {
//        let searchText = self.searchTextField.text
//        self.arrSearched.removeAll()
//        if searchText == "" {
//            self.arrSearched = self.originalData
//        } else {
//            for item in originalData {
//                let containedItem = item.categoryName.range(of: searchText!)
//                if containedItem != nil {
//                    arrSearched.append(item)
//                }
//            }
//        }
//    }
    
    func categoryTableViewSetup() {
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.categoryTableView.register(UINib(nibName: "PositionTableViewCell", bundle: nil), forCellReuseIdentifier: "PositionTableViewCell")
        self.categoryTableView.register(CategoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    func fetchCategories() {
        DispatchQueue.main.async {
            CategoryAndPositionModel.getCategories { category in
                self.categoriesViewModel = CategoriesViewModel()
                self.categoriesViewModel?.setCategories(category)
//                self.originalData.append(contentsOf: category)
                self.categoryTableView.reloadData()
            }
        }
    }

}

