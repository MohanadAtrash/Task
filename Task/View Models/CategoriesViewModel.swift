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
    
    /// Category representables
    private var categoryRepresentables: [CategoryTableViewHeaderRepresentable]
    
    /// Position representables
    private var positionRepresentables: [PositionTableViewCellRepresentable]
    
    /// Categories
    private var categories: [Category]
    
    /**
     Init categories view model
    */
    init() {
        self.categoryRepresentables = []
        self.positionRepresentables = []
        self.categories = []
    }
    
    /**
     Set categories
     */
    func setCategories(_ categories: [Category]) {
        self.categories.append(contentsOf: categories)
        self.buildCategoryRepresentables()
        self.buildPositionRepresentables()
    }
    
    /**
     Build category representables
     */
    func buildCategoryRepresentables() {
        for category in self.categories {
            self.categoryRepresentables.append(CategoryTableViewHeaderRepresentable(category))

        }
    }
    
    /**
     Build position representables
     */
    func buildPositionRepresentables() {
        for index in self.categoryRepresentables.indices {
            for index1 in self.categoryRepresentables[index].positions.indices {
                self.positionRepresentables.append(PositionTableViewCellRepresentable(self.categoryRepresentables[index].positions[index1]))
            }
        }
    }
    
    /**
     Get category representable
    */
    func getCategoryRepresentable(section: Int) -> CategoryTableViewHeaderRepresentable {
        return self.categoryRepresentables[section]
    }
    
    /**
     Get position representable
    */
    func getPositionRepresentable(index: IndexPath) -> PositionTableViewCellRepresentable {
        return self.positionRepresentables[index.row]
    }
    
    /**
     Get positions representables count
    */
    func getPositionRepresentablesCount(section: Int) -> Int {
        return self.categoryRepresentables[section].positions.count
    }
    
    /**
     Get position representables height
    */
    func getPositionRepresentableHeight(index: IndexPath) -> CGFloat {
        return self.positionRepresentables[index.row].cellHeight
    }
    
    /**
     Get category representables count
    */
    func getCategoryRepresentablesCount() -> Int {
        return self.categoryRepresentables.count
    }
    
    /**
     Get category representables height
    */
    func getCategoryRepresentableHeight(section: Int) -> CGFloat {
        return self.categoryRepresentables[section].headerHeight
    }

    
    
}
