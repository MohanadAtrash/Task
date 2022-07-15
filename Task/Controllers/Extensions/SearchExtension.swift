//
//  SearchExtension.swift
//  Task
//
//  Created by Mohannad Al Atrash on 15/07/2022.
//

import UIKit

extension CategoryAndPositionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search is \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(false)
    }
}
