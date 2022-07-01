//
//  PositionTableViewCellRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

class CategoryTableViewHeaderRepresentable {
    
    /// Category name
    private(set) var name: String
    
    /// Positions array
    private(set) var positions: [Position]
    
    /// Header reuse identifier
    var headerReuseIdentifier: String
    
    /// Header height
    var headerHeight: CGFloat
    
    /**
     Initializer of category header and position cell representable
     */
    init(_ category: Category) {
        self.name = category.name
        self.positions = category.positions
        self.headerReuseIdentifier = CategoryTableViewHeader.getReuseIdentifier()
        self.headerHeight = CategoryTableViewHeader.getHeight()
    }
    
    
}
