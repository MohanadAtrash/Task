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
    
    /// Selected categories
    var selectedCategories: [Category: HeaderSelection]
    
    /**
     Initializer
    */
    init() {
        let tableSectionRepresentable = TableSectionRepresentable()
        tableSectionRepresentable.cellsRepresentables = [IndicatorTableViewCellRepresentable()]
        self.representables = [tableSectionRepresentable]
        self.categories = []
        self.selectedCategories = [:]
    }
    
    /**
     Set categories
     */
    func setCategories(_ categories: [Category]) {
        self.categories.append(contentsOf: categories)
        self.buildRepresentables()
    }
    
    /**
     Build representables
     */
    func buildRepresentables() {
        self.representables = [] // To remove indicator
        for (index, category) in self.categories.enumerated() {
            self.representables.append(TableSectionRepresentable())
            self.representables[index].sectionHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
            for index1 in 0..<self.categories[index].positions.count {
                self.representables[index].cellsRepresentables.append(PositionTableViewCellRepresentable((category.positions[index1])))
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
     Get table view header representable
    */
    func getTableViewHeaderRepresentable(section: Int) -> TableViewHeaderRepresentable? {
        if let categoryHeaderRepresentable = self.representables[section].sectionHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
            return categoryHeaderRepresentable
        }
        return nil
    }
    
    /**
     Get table view cell representable
    */
    func getTableViewCellRepresentable(index: IndexPath) -> TableViewCellRepresentable {
        return self.representables[index.section].cellsRepresentables[index.row]
    }
    
    /**
     Get table view cell representables at section
     */
    func getTableViewCellRepresentablesAtSection(_ section: Int) -> [TableViewCellRepresentable] {
        return self.representables[section].cellsRepresentables
    }
    
    /**
     Check positions selections
     */
    func checkPositionsSelections(index: IndexPath) -> HeaderSelection {
        
        var headerSelection = HeaderSelection.unselected
        let positions = self.representables[index.section].cellsRepresentables as! [PositionTableViewCellRepresentable]
        var selectedPositions: Int = 0
        for position in positions {
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
        return headerSelection
    }
    
    /**
     Select position representables cells
     */
    func selectPositionTableViewCellRepresentables(at section: Int) {
        if let positionRepresentables = self.representables[section].cellsRepresentables as? [PositionTableViewCellRepresentable] {
            for index in 0..<(positionRepresentables.count) {
                positionRepresentables[index].setSelectedCell(true)
            }
        }
    }
    
    /**
     Unselect position representables cells
     */
    func unselectPositionTableViewCellRepresentables(at section: Int) {
        if let positionRepresentables = self.representables[section].cellsRepresentables as? [PositionTableViewCellRepresentable] {
            for index in 0..<(positionRepresentables.count) {
                positionRepresentables[index].setSelectedCell(false)
            }
        }
    }
    
    /**
     Get table view cell representables count
    */
    func getTableViewCellRepresentablesCount(section: Int) -> Int {
        if let positionRepresentables = self.representables[section].cellsRepresentables as? [PositionTableViewCellRepresentable] {
            return positionRepresentables.count
        }
        if let noDataRepresentable = self.representables[section].cellsRepresentables as? [NoDataTableViewCellRepresentable] {
            return noDataRepresentable.count
        }
        return 1
    }
    
    /**
     Get position representables height
    */
    func getPositionRepresentableHeight(index: IndexPath) -> CGFloat {
        if let positionRepresentable = self.representables[index.section].cellsRepresentables[index.row] as? PositionTableViewCellRepresentable {
            return positionRepresentable.cellHeight
        }
        if let noDataRepresentable = self.representables[index.section].cellsRepresentables[index.row] as? NoDataTableViewCellRepresentable {
            return noDataRepresentable.cellHeight
        }
        if let indicatorRepresentable = self.representables[index.section].cellsRepresentables[index.row] as? IndicatorTableViewCellRepresentable {
            return indicatorRepresentable.cellHeight
        }
        return 50
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
        if let headerRepresentable = self.representables[section].sectionHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
            return headerRepresentable.headerHeight
        }
        return 0
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
    func getCategory(_ section: Int) -> Category {
        return self.categories[section]
    }

}
