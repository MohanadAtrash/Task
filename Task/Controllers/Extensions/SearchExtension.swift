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
        self.categoriesViewModel?.searchedCategories = []
        self.categoriesViewModel?.searchedRepresentables = []
        let searchedCategories = (self.categoriesViewModel?.getCategories().filter({ $0.name.starts(with: searchText) }))!
//        let searchedPositions = (self.categoriesViewModel?.getPositions())?.filter({ $0.name.starts(with: searchText)})
//        print(searchedPositions)
        self.categoriesViewModel?.searchedCategories.append(contentsOf: searchedCategories)
        self.categoriesViewModel?.buildSearchedRepresentables()
        if searchText == "" {
            self.categoriesViewModel?.searching = false
        } else {
            self.categoriesViewModel?.searching = true
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
