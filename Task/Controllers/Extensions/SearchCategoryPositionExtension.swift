//
//  SearchCategoryPositionController.swift
//  Task
//
//  Created by Mohannad Al Atrash on 03/07/2022.
//

import UIKit

/**
 Category And Position View Controller Extension
// */
//extension CategoryAndPositionViewController: UITextFieldDelegate {
//    
//    /**
//     Text field should return
//     */
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let enteredData = textField.text {
//            var searchedTableSectionsRepresentables = [TableSectionRepresentable]()
//            if let allCategories = categoriesViewModel?.getCategories() {
//                for category in allCategories {
//                    
//                    let tableSection = TableSectionRepresentable()
//
//                    for position in category.positions {
//                        if position.name.starts(with: enteredData) == true {
//                            tableSection.cellsRepresentables.append(PositionTableViewCellRepresentable(position))
//                        }
//                    }
//                    
//                    if (category.name.starts(with: enteredData) == true) || !tableSection.cellsRepresentables.isEmpty {
//                        tableSection.sectionHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
//                    }
//                    
//                    if !tableSection.cellsRepresentables.isEmpty || tableSection.sectionHeaderRepresentable != nil {
//                        searchedTableSectionsRepresentables.append(tableSection)
//                        tableSection.isExpanded = true
//                    }
//                }
//                
//                if !searchedTableSectionsRepresentables.isEmpty {
//                    self.categoriesViewModel?.setSearchedRepresentables(searchedTableSectionsRepresentables)
//                } else {
//                    self.categoriesViewModel?.unsetExpandedRepresentables()
//                }
//                self.categoryTableView.reloadData()
//            }
//        }
//        
//        textField.resignFirstResponder()
//        textField.text = ""
//        return true
//    }
//    
//    
//}

