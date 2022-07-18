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
        let searchedCategories = (self.categoriesViewModel?.getCategories().filter({ $0.name.starts(with: searchText) }))!
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
