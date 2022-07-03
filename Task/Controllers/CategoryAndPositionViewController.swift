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
    
    /// Refresh control
    let refreshControl = UIRefreshControl()
    
    /// Categories view model
    var categoriesViewModel: CategoriesViewModel?
    
    /// Indicator view model
    var indicatorViewModel: IndicatorViewModel?

    
    /**
     View did load
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Indicator table view cell setup
        self.indicatorCellViewSetup()
        // Category table view setup
        self.categoryTableViewSetup()
        // Fetch categories
        self.fetchCategories()
        
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.categoryTableView.addSubview(refreshControl)
        
//        self.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
        
        
    
    }
    
    @objc func refresh(_ sender: AnyObject) {
        sender.beginRefreshing()
        print("Refreshed!")
        sender.endRefreshing()
    }
    
    /**
     Cateogry table view setup
     */
    func categoryTableViewSetup() {
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.categoryTableView.register(UINib(nibName: "PositionTableViewCell", bundle: nil), forCellReuseIdentifier: "PositionTableViewCell")
        self.categoryTableView.register(CategoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        self.categoryTableView.register(UINib(nibName: "IndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: "IndicatorTableViewCell")
    }
    
    /**
     Fetch categories
     */
    func fetchCategories() {
        DispatchQueue.main.async {
            CategoryAndPositionModel.getCategories { category in
                self.categoriesViewModel = CategoriesViewModel()
                self.categoriesViewModel?.setCategories(category)
                self.categoryTableView.reloadData()
            }
        }
    }
    
    func indicatorCellViewSetup() {
        self.indicatorViewModel = IndicatorViewModel()
        self.searchView.isHidden = true
        self.categoryTableView.reloadData()
    }

}

