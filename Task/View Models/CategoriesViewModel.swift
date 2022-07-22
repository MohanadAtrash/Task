//
//  CategoriesPositionsViewModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit
import Alamofire

/**
 Categories View Model
 */
class CategoriesViewModel {
    
    /// Representables
    var representables: [TableSectionRepresentable]
    
    /// Categories
    var categories: [Category]
    
    /// Selected categories
    var selectedCategoriesDictionary: [Category: [Position]]
    
    /**
     Initializer
    */
    init() {
        let tableSectionRepresentable = TableSectionRepresentable()
        tableSectionRepresentable.tableViewCellRepresentables = [IndicatorTableViewCellRepresentable()]
        self.representables = [tableSectionRepresentable]
        self.categories = []
        self.selectedCategoriesDictionary = [:]
    }
    
    /**
     Set categories
     */
    func setCategories(_ categories: [Category]) {
        self.categories.append(contentsOf: categories)
        self.buildRepresentables()
        self.updateRepresentables(self.categories)
    }
    
    /**
     Build no data representable
     */
    func buildNoDataRepresentable() {
        self.representables = [] // To remove searched representables
        let tableSectionRepresentable = TableSectionRepresentable()
        tableSectionRepresentable.tableViewCellRepresentables = [NoDataTableViewCellRepresentable()]
        self.representables = [tableSectionRepresentable]
    }
    
    /**
     Build representables
     */
    func buildRepresentables() {
        self.representables = [] // To remove indicator representable or searched representables
        for (categoryIndex, category) in self.categories.enumerated() {
            self.representables.append(TableSectionRepresentable())
            self.representables[categoryIndex].tableViewHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
            for positionIndex in 0..<self.categories[categoryIndex].positions.count {
                self.representables[categoryIndex].tableViewCellRepresentables.append(PositionTableViewCellRepresentable((category.positions[positionIndex])))
            }
        }
    }
    
    /**
     Build searched representables
     */
    func buildSearchedRepresentables(_ searchedCategories: [Category: [Position]]) {
        self.representables = [] // To remove original representables
        var categoryIndex = 0
        for (category, positions) in searchedCategories.sorted(by: { v1, v2 in
            return v1.key.id < v2.key.id
        }) {
            self.representables.append(TableSectionRepresentable())
            self.representables[categoryIndex].isExpanded = true
            self.representables[categoryIndex].tableViewHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
            for positionIndex in 0..<positions.count {
                self.representables[categoryIndex].tableViewCellRepresentables.append(PositionTableViewCellRepresentable((positions[positionIndex])))
            }
            categoryIndex = categoryIndex + 1
        }
    }
    
    /**
     Update representables
     */
    func updateRepresentables(_ categories: [Category]) {
        for (index, category) in categories.enumerated() {
            if let categoryTableViewHeaderRepresentable = self.representables[index].tableViewHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
                if let positionTableViewCellRepresentables = self.representables[index].tableViewCellRepresentables as? [PositionTableViewCellRepresentable] {
                    if self.selectedCategoriesDictionary[category] != nil { // if key is found
                        if self.selectedCategoriesDictionary[category]?.count == category.positions.count {
                            categoryTableViewHeaderRepresentable.setSelectedHeader(.selected)
                            for positionTableViewCellRepresentable in positionTableViewCellRepresentables {
                                positionTableViewCellRepresentable.setSelectedCell(true)
                            }
                        } else {
                            categoryTableViewHeaderRepresentable.setSelectedHeader(.partiallySelected)
                            for positionTableViewCellRepresentable in positionTableViewCellRepresentables {
                                for selectedIndex in selectedCategoriesDictionary[category]!.indices {
                                    if self.selectedCategoriesDictionary[category]?[selectedIndex].id == positionTableViewCellRepresentable.id {
                                        positionTableViewCellRepresentable.setSelectedCell(true)
                                    }
                                }
                            }
                        }
                    } else {
                        categoryTableViewHeaderRepresentable.setSelectedHeader(.unselected)
                    }
                }
            }
        }
    }

    /**
     Get table section expanded status
     */
    func getTableSectionExpandedStatus(_ section: Int) -> Bool {
        return self.representables[section].isExpanded
    }
    
    /**
     Get table view header representable
    */
    func getTableViewHeaderRepresentable(_ section: Int) -> TableViewHeaderRepresentable? {
        if let categoryHeaderRepresentable = self.representables[section].tableViewHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
            return categoryHeaderRepresentable
        }
        return nil
    }
    
    /**
     Get table view cell representable
    */
    func getTableViewCellRepresentable(_ index: IndexPath) -> TableViewCellRepresentable {
        return self.representables[index.section].tableViewCellRepresentables[index.row]
    }
    
    /**
     Check positions selections
     */
    func checkPositionsSelections(_ index: IndexPath) -> HeaderSelection {
        
        var headerSelection = HeaderSelection.unselected
        let positions = self.representables[index.section].tableViewCellRepresentables as! [PositionTableViewCellRepresentable]
        var selectedPositions: Int = 0
        for position in positions {
            if position.selectedCell == true {
                selectedPositions = selectedPositions + 1
            }
        }
        if selectedPositions == self.representables[index.section].tableViewCellRepresentables.count {
            headerSelection = .selected
        } else if selectedPositions == 0 {
            headerSelection = .unselected
        } else {
            headerSelection = .partiallySelected
        }
        return headerSelection
    }
    
    /**
     Select position representables cells
     */
    func selectPositionTableViewCellRepresentables(_ section: Int) {
        if let positionRepresentables = self.representables[section].tableViewCellRepresentables as? [PositionTableViewCellRepresentable] {
            for index in 0..<(positionRepresentables.count) {
                positionRepresentables[index].setSelectedCell(true)
            }
        }
    }
    
    /**
     Unselect position representables cells
     */
    func unselectPositionTableViewCellRepresentables(_ section: Int) {
        if let positionRepresentables = self.representables[section].tableViewCellRepresentables as? [PositionTableViewCellRepresentable] {
            for index in 0..<(positionRepresentables.count) {
                positionRepresentables[index].setSelectedCell(false)
            }
        }
    }
    
    /**
     Get table view cell representables count
    */
    func getTableViewCellRepresentablesCount(_ section: Int) -> Int {
        if let positionRepresentables = self.representables[section].tableViewCellRepresentables as? [PositionTableViewCellRepresentable] {
            return positionRepresentables.count
        }
        if let noDataRepresentable = self.representables[section].tableViewCellRepresentables as? [NoDataTableViewCellRepresentable] {
            return noDataRepresentable.count
        }
        return 1
    }
    
    /**
     Get position representables height
    */
    func getPositionRepresentableHeight(_ index: IndexPath) -> CGFloat {
        return self.representables[index.section].tableViewCellRepresentables[index.row].cellHeight
    }
    
    /**
     Get category representables count
    */
    func getCategoryRepresentablesCount() -> Int {
        return self.representables.count
    }
    
    /**
     Get category representables height
    */
    func getCategoryRepresentableHeight(_ section: Int) -> CGFloat {
        if let headerRepresentable = self.representables[section].tableViewHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
            return headerRepresentable.headerHeight
        }
        return 0
    }
    
    /**
     Get categories
     */
    func getCategories() -> [Category] {
        return self.categories
    }
    
    /**
     Unset expanded table section representables
     */
    func unsetExpandedTableSectionRepresentables() {
        for index in self.representables.indices {
            self.representables[index].isExpanded = false
        }
    }
    
    /**
     Get table section representable
     */
    func getTableSectionRepresentable(_ section: Int) -> TableSectionRepresentable {
        return self.representables[section]
    }
    
    /**
     Get category
     */
    func getCategory(_ section: Int) -> Category? {
        return self.categories[section]
    }
    
    /**
     Get position
     */
    func getPosition(_ index: IndexPath) -> Position? {
        return self.categories[index.section].positions[index.row]
    }
    
    /**
     Get position if selected
     */
    func getPositionIfSelected(_ index: IndexPath) -> Position? {
        if let positionRepresentable = self.representables[index.section].tableViewCellRepresentables[index.row] as? PositionTableViewCellRepresentable {
            if positionRepresentable.selectedCell == true {
                return self.categories[index.section].positions[index.row]
            }
        }
        return nil
    }
    
    /**
     Get table view cell representables
     */
    func getTableViewCellRepresentables(_ section: Int) -> [TableViewCellRepresentable] {
        return self.representables[section].tableViewCellRepresentables
    }
    
    /**
     Get positions
     */
    func getPositions(_ section: Int) -> [Position]? {
        return self.categories[section].positions
    }
    
    func getCategoryPositionsDictionary() -> [Category: [Position]] {
        var categoryPositionsDictionary: [Category: [Position]] = [:]
        for category in self.categories {
            categoryPositionsDictionary[category] = category.positions
        }
        return categoryPositionsDictionary
    }
    
    /**
     Get selected categories
     */
    func getSelectedCategories() -> [Category: [Position]] {
        return self.selectedCategoriesDictionary
    }

    /**
     Get postions count at category id
     */
    func getPositionsCountForCategoryId(_ id: Int) -> Int {
        for category in self.categories {
            if category.id == id {
                return category.positions.count
            }
        }
        return 0
    }
}
