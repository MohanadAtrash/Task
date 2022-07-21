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
    var selectedCategories: [Category: [Position]]
    
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
        self.updateRepresentables(self.categories)
    }
    
    /**
     Build no data representable
     */
    func buildNoDataRepresentable() {
        self.representables = []
        let tableSectionRepresentable = TableSectionRepresentable()
        tableSectionRepresentable.cellsRepresentables = [NoDataTableViewCellRepresentable()]
        self.representables = [tableSectionRepresentable]
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
     Build searched representables
     */
    func buildSearchedRepresentables(_ searchedCategories: [Category]) {
        self.representables = [] // To remove original representables
        for (index, category) in searchedCategories.enumerated() {
            self.representables.append(TableSectionRepresentable())
            self.representables[index].sectionHeaderRepresentable = CategoryTableViewHeaderRepresentable(category)
            for index1 in 0..<searchedCategories[index].positions.count {
                self.representables[index].cellsRepresentables.append(PositionTableViewCellRepresentable((category.positions[index1])))
            }
        }
    }
    
    /**
     Update reprepresentables
     */
    func updateRepresentables(_ categories: [Category]) {
        for (index, category) in categories.enumerated() {
            if let categoryTableViewHeaderRepresentable = self.representables[index].sectionHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
                if let positionTableViewCellRepresentables = self.representables[index].cellsRepresentables as? [PositionTableViewCellRepresentable] {
                    if self.selectedCategories[category] != nil { // if key is found
                        if self.selectedCategories[category]?.count == category.positions.count {
                            categoryTableViewHeaderRepresentable.setSelectedHeader(.selected)
                            for positionTableViewCellRepresentable in positionTableViewCellRepresentables {
                                positionTableViewCellRepresentable.setSelectedCell(true)
                            }
                        } else {
                            categoryTableViewHeaderRepresentable.setSelectedHeader(.partiallySelected)
                            for positionTableViewCellRepresentable in positionTableViewCellRepresentables {
                                for selectedIndex in selectedCategories[category]!.indices {
                                    if self.selectedCategories[category]?[selectedIndex].id == positionTableViewCellRepresentable.id {
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
        if let headerRepresentable = self.representables[section].sectionHeaderRepresentable as? CategoryTableViewHeaderRepresentable {
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
        if let positionRepresentable = self.representables[index.section].cellsRepresentables[index.row] as? PositionTableViewCellRepresentable {
            if positionRepresentable.selectedCell == true {
                return self.categories[index.section].positions[index.row]
            }
        }
        return nil
    }
    
    /**
     Set searched categories
     */
    func setSearchedCategories(_ searchedCategories: [Category]) {
        
    }
    
    /**
     Get table view cell representables
     */
    func getTableViewCellRepresentables(_ section: Int) -> [TableViewCellRepresentable] {
        return self.representables[section].cellsRepresentables
    }
    
    /**
     Get positions at section
     */
    func getPositionsAtSection(_ section: Int) -> [Position]? {
        return self.categories[section].positions
    }
    
    /**
     Get selected categories
     */
    func getSelectedCategories() -> [Category: [Position]] {
        return self.selectedCategories
    }

    /**
     Get postions count at category id
     */
    func getPositionsCountAtCategoryID(_ id: Int) -> Int {
        for category in categories {
            if category.id == id {
                return category.positions.count
            }
        }
        return 0
    }
}
