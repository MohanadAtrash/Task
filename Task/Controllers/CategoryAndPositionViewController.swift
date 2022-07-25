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
    
    /// Bottom view
    @IBOutlet weak var bottomView: BottomView!
    /// Initial view height constraint
    var initialViewHeightConstraint: NSLayoutConstraint!
    /// Expanded view height constraint
    var expandedViewHeightConstraint: NSLayoutConstraint!
    var changeableViewHeightConstraint: NSLayoutConstraint!
    var zeroViewHeightConstraint: NSLayoutConstraint!
    
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
        // Search setup
        self.searchSetup()
        // Refresh table view
        self.refreshTableViewSetup()
        // Bottom view setup
        self.bottomViewSetup()
    }
    
    /**
     Bottom view setup
     */
    func bottomViewSetup() {
        self.bottomView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
        self.bottomView.selectedPositionsLabel.text = ""
        self.bottomView.selectedCategoriesLabel.text = ""
        self.bottomView.selectedCategoriesLabel.numberOfLines = 1
        self.bottomView.selectedPositionsLabel.numberOfLines = 1
        self.bottomView.isUserInteractionEnabled = true
        
        // Constraints
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.accessibilityScroll(.up)
        self.initialViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 71)
        self.expandedViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 600)
        self.changeableViewHeightConstraint = self.bottomView.heightAnchor.constraint(greaterThanOrEqualToConstant: 71)
        self.zeroViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 0)
        
        self.initialViewHeightConstraint.isActive = false
        self.expandedViewHeightConstraint.isActive = false
        self.changeableViewHeightConstraint.isActive = false
        self.zeroViewHeightConstraint.isActive = true
    }
    
    /**
     Handle pan gesture
     */
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: self.bottomView)
        self.changeableViewHeightConstraint.isActive = false
        self.expandedViewHeightConstraint.isActive = false
        self.zeroViewHeightConstraint.isActive = false
        if gesture.state == .began {
            self.initialViewHeightConstraint.isActive = true
        } else if gesture.state == .changed {
            self.initialViewHeightConstraint.isActive = false
            self.expandedViewHeightConstraint.isActive = false
            changeableViewHeightConstraint = self.bottomView.heightAnchor.constraint(greaterThanOrEqualToConstant: 71)
            changeableViewHeightConstraint.isActive = true
        } else if gesture.state == .ended {
            changeableViewHeightConstraint.isActive = false
            if velocity.y < 0 {
                self.expandedViewHeightConstraint.isActive = true
                self.bottomView.selectedCategoriesLabel.numberOfLines = 0
                self.bottomView.selectedPositionsLabel.numberOfLines = 0
            } else {
                self.expandedViewHeightConstraint.isActive = false
                self.changeableViewHeightConstraint.isActive = false
                self.initialViewHeightConstraint.isActive = true
                self.zeroViewHeightConstraint.isActive = false
                self.bottomView.selectedCategoriesLabel.numberOfLines = 1
                self.bottomView.selectedPositionsLabel.numberOfLines = 1
            }
        }
    }
    
    /**
     Bottom  view setup
     */
    func bottomViewLogicSetup() {
        self.bottomView.selectedCategoriesLabel.text = ""
        self.bottomView.selectedPositionsLabel.text = ""
        if self.categoriesViewModel?.getSelectedCategoriesDictionary().count != 0 {
            var selectedCategories: [String] = []
            var selectedPositions: [Position] = []
            for (key, values) in self.categoriesViewModel!.getSelectedCategoriesDictionary() {
                if values.count == self.categoriesViewModel?.getPositionsCountForCategoryId(key.id) {
                    selectedCategories.append(key.name)
                } else {
                    selectedPositions.append(contentsOf: values)
                }
            }
            if !selectedCategories.isEmpty {
                self.bottomView.selectedCategoriesLabel.text = "Selected Categories: "
            }
            if !selectedPositions.isEmpty {
                self.bottomView.selectedPositionsLabel.text = "Selected Positions: "
            }
            
            for categoryName in selectedCategories {
                self.bottomView.selectedCategoriesLabel.text = self.bottomView.selectedCategoriesLabel.text! + categoryName + ", "
            }
            
            for position in selectedPositions {
                self.bottomView.selectedPositionsLabel.text = self.bottomView.selectedPositionsLabel.text! + position.name + ", "
            }
            
            if selectedPositions.isEmpty && selectedCategories.isEmpty {
                self.initialViewHeightConstraint.isActive = false
                self.expandedViewHeightConstraint.isActive = false
                self.changeableViewHeightConstraint.isActive = false
                self.zeroViewHeightConstraint.isActive = true
            } else {
                self.zeroViewHeightConstraint.isActive = false
                self.initialViewHeightConstraint.isActive = false
                self.expandedViewHeightConstraint.isActive = false
                self.changeableViewHeightConstraint.isActive = false
            }
            
        }
        
    }
    
    /**
     Indicator cell view setup
     */
    func indicatorCellViewSetup() {
        self.categoriesViewModel = CategoriesViewModel()
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
        self.categoryTableView.register(CategoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CategoryTableViewHeader.getReuseIdentifier())
        self.categoryTableView.register(UINib(nibName: PositionTableViewCell.getReuseIdentifier(), bundle: nil), forCellReuseIdentifier: PositionTableViewCell.getReuseIdentifier())
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
            self.categoriesViewModel?.categories = []
            CategoryModel.getCategories { category in
                self.categoriesViewModel?.setCategories(category)
                self.categoryTableView.reloadData()
            }
            sender.endRefreshing()
        }
    }
}

