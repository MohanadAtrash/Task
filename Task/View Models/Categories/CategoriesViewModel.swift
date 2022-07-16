//
//  CategoriesPositionsViewModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Categories View Model
 */
class CategoriesViewModel {
    
    /// Representables
    var representables: [TableSectionRepresentable]
    
    /// Categories
    var categories: [Category]
    
    /// Searched categories
    var searchedCategories: [Category]
    
    /// Searching status
    var searching: Bool
    
    /// Searched representables
    var searchedRepresentables: [TableSectionRepresentable]
    
    /**
     Initializer
    */
    init() {
        let tableSectionRepresentable = TableSectionRepresentable()
        self.representables = [tableSectionRepresentable]
        self.categories = []
        self.searchedCategories = []
        self.searchedRepresentables = []
        self.searching = false
    }
    
    /**
     Set categories
     */
    func setCategories(_ categories: [Category]) {
        self.categories.append(contentsOf: categories)
        self.buildRepresentables()
    }
    
    /**
     Build category representables
     */
    func buildRepresentables() {
        for (index, category) in self.categories.enumerated() {
            self.representables.append(TableSectionRepresentable())
            self.representables[index].sectionHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
            for index1 in 0..<self.categories[index].positions.count {
                self.representables[index].cellsRepresentables.append(PositionTableViewCellRepresentable(category.positions[index1]))
            }
        }
    }
    
    /**
     Build searched representables
     */
    func buildSearchedRepresentables() {
        for (index, category) in self.searchedCategories.enumerated() {
            self.searchedRepresentables.append(TableSectionRepresentable())
            self.searchedRepresentables[index].sectionHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
            for index1 in 0..<self.categories[index].positions.count {
                self.searchedRepresentables[index].cellsRepresentables.append(PositionTableViewCellRepresentable(category.positions[index1]))
            }
        }
    }
    
    /**
     Get table section expanded status
     */
    func getTableSectionExpandedStatus(section: Int) -> Bool {
        return self.representables[section].isExpanded
    }
    
    /**
     Get category representable
    */
    func getCategoryRepresentable(section: Int) -> CategoryTableViewHeaderRepresentable? {
        if self.searching == true && !self.searchedRepresentables.isEmpty {
            return self.searchedRepresentables[section].sectionHeaderRepresentable ?? nil
        }
        return self.representables[section].sectionHeaderRepresentable ?? nil
    }
    
    /**
     Get position representable
    */
    func getPositionRepresentable(index: IndexPath) -> PositionTableViewCellRepresentable {
        if self.searching == true && !self.searchedCategories.isEmpty {
            return self.searchedRepresentables[index.section].cellsRepresentables[index.row]
        }
        return self.representables[index.section].cellsRepresentables[index.row]
    }
    
    /**
     Check positions selections
     */
    func checkPositionsSelections(index: IndexPath) -> Selection {
        var headerSelection = Selection.unselected
        var selectedPositions: Int = 0
        if self.searching == true && !self.searchedCategories.isEmpty  {
            for position in self.searchedRepresentables[index.section].cellsRepresentables {
                if position.selectedCell == true {
                    selectedPositions = selectedPositions + 1
                }
            }
            if selectedPositions == self.searchedRepresentables[index.section].cellsRepresentables.count {
                headerSelection = .selected
            } else if selectedPositions == 0 {
                headerSelection = .unselected
            } else {
                headerSelection = .partiallySelected
            }
        } else {
            for position in self.representables[index.section].cellsRepresentables {
                if position.selectedCell == true {
                    selectedPositions = selectedPositions + 1
                }
            }
            if selectedPositions == self.representables[index.section].cellsRepresentables.count {
                headerSelection = .selected
            } else if selectedPositions == 0 {
                headerSelection = .unselected
            } else {
                headerSelection = .partiallySelected
            }
        }
        return headerSelection
    }
    
    /**
     Select position representables cells
     */
    func selectPositionRepresentables(at section: Int) {
        if self.searching == true && !self.searchedCategories.isEmpty {
            for index in 0..<(self.searchedRepresentables[section].cellsRepresentables.count) {
                self.searchedRepresentables[section].cellsRepresentables[index].selectedCell = true
            }
        } else {
            for index in 0..<(self.representables[section].cellsRepresentables.count) {
                self.representables[section].cellsRepresentables[index].selectedCell = true
            }
        }
    }
    
    /**
     Unselect position representables cells
     */
    func unselectPositionRepresentables(at section: Int) {
        if self.searching == true && !self.searchedCategories.isEmpty {
            for index in 0..<(self.searchedRepresentables[section].cellsRepresentables.count) {
                self.searchedRepresentables[section].cellsRepresentables[index].selectedCell = false
            }
        } else {
            for index in 0..<(self.representables[section].cellsRepresentables.count) {
                self.representables[section].cellsRepresentables[index].selectedCell = false
            }
        }
    }
    
    /**
     Get positions representables count
    */
    func getPositionRepresentablesCount(section: Int) -> Int {
        return self.representables[section].cellsRepresentables.count
    }
    
    /**
     Get position representables height
    */
    func getPositionRepresentableHeight(index: IndexPath) -> CGFloat {
        return self.representables[index.section].cellsRepresentables[index.row].cellHeight
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
    func getCategoryRepresentableHeight(section: Int) -> CGFloat {
        return self.representables[section].sectionHeaderRepresentable?.headerHeight ?? 0
    }
    
    /**
     Get table section data status
     */
    func getTableSectionDataStatus() -> Bool {
        if self.representables.isEmpty {
            return false
        }
        return true
    }
    
    /**
     Get categories
     */
    func getCategories() -> [Category] {
        return self.categories
    }
    
    /**
     Get positions
     */
    func getPositions() -> [Position] {
        var allPositions: [Position] = []
        for category in self.categories {
            allPositions.append(contentsOf: category.positions)
        }
        return allPositions
    }
    
    /**
     Unset expanded representables
     */
    func unsetExpandedRepresentables() {
        if self.searching == true && !self.searchedCategories.isEmpty {
            for index in self.searchedRepresentables.indices {
                self.searchedRepresentables[index].isExpanded = false
            }
        } else {
            for index in self.representables.indices {
                self.representables[index].isExpanded = false
            }
        }
    }
    
    /**
     Get section representable
     */
    func getSectionRepresentable(_ section: Int) -> TableSectionRepresentable {
        return self.representables[section]
    }
    
    /**
     Get searchedd representables count
     */
    func getSearchedRepresentablesCount() -> Int {
        return self.searchedRepresentables.count
    }

}
