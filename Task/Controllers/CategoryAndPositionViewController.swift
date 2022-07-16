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
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Category table view
    @IBOutlet weak var categoryTableView: UITableView!
    
    /// Refresh control
    private let refreshControl = UIRefreshControl()
    
    /// Categories view model
    var categoriesViewModel: CategoriesViewModel?
    
    /// Indicator view model
    var indicatorViewModel: IndicatorViewModel?
    
    /// No data view model
    var noDataViewModel: NoDataViewModel?

    
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
        // No data setup
        self.noDataSetup()
        // Search setup
        self.searchSetup()
        // Refresh table view
        self.refreshTableViewSetup()
    }
    
    /**
     Indicator cell view setup
     */
    func indicatorCellViewSetup() {
        self.indicatorViewModel = IndicatorViewModel()
        self.searchBar.isHidden = true
        self.categoryTableView.reloadData()
    }
    
    /**
     Cateogry table view setup
     */
    func categoryTableViewSetup() {
        self.searchBar.delegate = self
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.categoryTableView.register(UINib(nibName: PositionTableViewCell.getReuseIdentifier(), bundle: nil), forCellReuseIdentifier: PositionTableViewCell.getReuseIdentifier())
        self.categoryTableView.register(CategoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CategoryTableViewHeader.getReuseIdentifier())
        self.categoryTableView.register(UINib(nibName: IndicatorTableViewCell.getReuseIdentifier(), bundle: nil), forCellReuseIdentifier: IndicatorTableViewCell.getReuseIdentifier())
        self.categoryTableView.register(UINib(nibName: NoDataTableViewCell.getReuseIdentifier(), bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.getReuseIdentifier())
    }
    
    /**
     Fetch categories
     */
    func fetchCategories() {
        DispatchQueue.main.async {
            CategoryModel.getCategories { category in
                self.categoriesViewModel = CategoriesViewModel()
                self.categoriesViewModel?.setCategories(category)
                self.categoryTableView.reloadData()
            }
        }
    }
    
    /**
     No data setup
     */
    func noDataSetup() {
        self.noDataViewModel = NoDataViewModel()
    }
    
    /**
     Search setup
     */
    func searchSetup() {
        self.searchBar.backgroundColor = .white
        self.searchBar.barTintColor = .white
        self.searchBar.frame.size.height = 42
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search for categories/positions",
            attributes: [.foregroundColor: UIColor(red: 0.808, green: 0.808, blue: 0.808, alpha: 1)]
        )
        self.searchBar.searchTextField.backgroundColor = .white
        self.searchBar.searchTextField.font = .systemFont(ofSize: 12)
        self.searchBar.searchTextField.textColor = .black
        self.searchBar.searchTextField.leftView?.tintColor = UIColor(red: 0.808, green: 0.808, blue: 0.808, alpha: 1)
        self.searchBar.searchTextField.leftView?.sizeToFit()
        self.searchBar.searchTextField.leftView?.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.searchBar.searchTextField.leftView?.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    /**
     Refresh table view setup
     */
    func refreshTableViewSetup() {
        self.refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.categoryTableView.addSubview(refreshControl)
    }
    
    /**
     Refresh
     */
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            sender.beginRefreshing()
//            self.categoriesViewModel?.buildRepresentables()
            self.categoryTableView.reloadData()
            sender.endRefreshing()
        }
    }
}

