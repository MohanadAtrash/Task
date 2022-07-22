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
    }
    
    /**
     Handle pan gesture
     */
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        let startPosition = gesture.location(in: self.bottomView)
        if gesture.state == .began {
            self.bottomView.selectedCategoriesLabel.numberOfLines = 0
            self.bottomView.selectedPositionsLabel.numberOfLines = 0
        } else if gesture.state == .changed {
//            let endPosition = gesture.location(in: self.bottomView)
//            let difference = endPosition.y - startPosition.y
            self.bottomView.translatesAutoresizingMaskIntoConstraints = false
//            let newHeight = self.bottomView.originalHeight - difference
//            let heightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: newHeight)
//            heightConstraint.isActive = true
//            self.bottomView.layoutIfNeeded()
            let translation = gesture.translation(in: self.bottomView)
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.bottomView.transform = .identity
//                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -300)
            }
            self.bottomView.selectedCategoriesLabel.numberOfLines = 1
            self.bottomView.selectedPositionsLabel.numberOfLines = 1
        }
    }
    
    /**
     Bottom  view setup
     */
    func bottomViewLogicSetup() {
        self.bottomView.selectedCategoriesLabel.text = ""
        self.bottomView.selectedPositionsLabel.text = ""
        if self.categoriesViewModel?.getSelectedCategories().count != 0 {
            var selectedCategories: [String] = []
            var selectedPositions: [[Position]] = [[]]
            var index: Int = 0
            for (key, values) in self.categoriesViewModel!.getSelectedCategories() {
                if values.count == self.categoriesViewModel?.getPositionsCountForCategoryId(key.id) {
                    selectedCategories.append(key.name)
                } else {
                    selectedPositions[index].append(contentsOf: values)
                    index = index + 1
                }
            }
            if !selectedCategories.isEmpty {
                self.bottomView.selectedCategoriesLabel.text = "Selected Categories: "
            }
            if !selectedPositions[0].isEmpty {
                self.bottomView.selectedPositionsLabel.text = "Selected Positions: "
            }
            
            for categoryName in selectedCategories {
                self.bottomView.selectedCategoriesLabel.text = self.bottomView.selectedCategoriesLabel.text! + categoryName + ", "
            }
            
            for positions in selectedPositions {
                for position in positions {
                    self.bottomView.selectedPositionsLabel.text = self.bottomView.selectedPositionsLabel.text! + position.name + ", "
                }
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
//            self.categoriesViewModel?.representables = []
            CategoryModel.getCategories { category in
                self.categoriesViewModel?.setCategories(category)
                self.categoryTableView.reloadData()
            }
            sender.endRefreshing()
        }
        
    }
}

