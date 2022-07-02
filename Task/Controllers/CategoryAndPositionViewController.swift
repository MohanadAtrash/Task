//
//  ViewController.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Category And Position View Controller
 */
class CategoryAndPositionViewController: UIViewController {

    /// Search view
    @IBOutlet weak var searchView: UIView!
    /// Search text field
    @IBOutlet weak var searchTextField: UITextField!
    /// Category table view
    @IBOutlet weak var categoryTableView: UITableView!
    
    /// Categories view model
    var categoriesViewModel: CategoriesViewModel?

//    var originalData: [Category] = []
//    var arrSearched: [Category] = []
    
    /**
     View did load
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Category table view setup
        self.categoryTableViewSetup()
        // Fetch categories
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
    
    /**
     Cateogry table view setup
     */
    func categoryTableViewSetup() {
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.categoryTableView.register(UINib(nibName: "PositionTableViewCell", bundle: nil), forCellReuseIdentifier: "PositionTableViewCell")
        self.categoryTableView.register(CategoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    /**
     Fetch categories
     */
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

