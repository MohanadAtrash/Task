//
//  SearchExtension.swift
//  Task
//
//  Created by Mohannad Al Atrash on 15/07/2022.
//

import UIKit

/**
 Category And Position View Controller Extension
 */
extension CategoryAndPositionViewController: UISearchBarDelegate {
    
    /**
     Search bar text did change
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let categoryPositionsDictionary = self.categoriesViewModel?.getCategoryPositionsDictionary() {
            
            var searchedCategoryPositionsDictionary: [Category: [Position]] = [:]
            var searchedCategories: [Category] = []
            
            for category in categoryPositionsDictionary.keys {
                
                if category.name.starts(with: searchText) { // Category name check
                    searchedCategoryPositionsDictionary[category] = []
                }
                // Positions names check
                searchedCategoryPositionsDictionary[category] = categoryPositionsDictionary[category]?.filter({ position in
                    position.name.starts(with: searchText)
                })
                
                if category.name.starts(with: searchText) || searchedCategoryPositionsDictionary[category]?.count != 0 { // Search matches some categories
                    searchedCategories.append(category)
                } else {
                    searchedCategoryPositionsDictionary[category] = nil
                }
            }
            
            if searchText == "" { // Text field is empty
                self.categoriesViewModel?.buildRepresentables()
                self.categoriesViewModel?.updateRepresentables(searchedCategories)
            } else {
                if searchedCategories.count == 0 { // Search is failed
                    self.categoriesViewModel?.buildNoDataRepresentable()
                } else { // Search is successful
                    self.categoriesViewModel?.buildSearchedRepresentables(searchedCategoryPositionsDictionary)
                    self.categoriesViewModel?.updateRepresentables(searchedCategories)
                }
            }
        }
        self.categoryTableView.reloadData()
    }
    
    /**
     Search bar search button clicked
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    /**
     Search bar should begin editing
     */
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(false)
    }
}
