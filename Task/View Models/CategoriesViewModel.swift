//
//  CategoriesPositionsViewModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Category Position View Model
 */
class CategoriesViewModel {
    
    /// Representables
    var representables: [TableSectionRepresentable]
    
    /// Categories
    private var categories: [Category]
    
    /**
     Init categories view model
    */
    init() {
        let tableSectionRepresentable = TableSectionRepresentable()
        self.representables = [tableSectionRepresentable]
        self.categories = []
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
    
    func getTableSectionExpanded(section: Int) -> Bool {
        return self.representables[section].isExpanded
    }
    
    /**
     Get category representable
    */
    func getCategoryRepresentable(section: Int) -> CategoryTableViewHeaderRepresentable? {
        return self.representables[section].sectionHeaderRepresentable ?? nil
    }
    
    /**
     Get position representable
    */
    func getPositionRepresentable(index: IndexPath) -> PositionTableViewCellRepresentable {
        return self.representables[index.section].cellsRepresentables[index.row]
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

}
