//
//  PositionTableViewCellRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit
import Alamofire

/**
 Header Selection Enumeration
 */
enum HeaderSelection {
    /// Selected
    case selected
    /// Unselected
    case unselected
    /// Partially selected
    case partiallySelected
}

/**
 Category Table View Header Representable
 */
class CategoryTableViewHeaderRepresentable: TableViewHeaderRepresentable {
    
    /// Category name
    private(set) var name: String
    
    /// Positions array
    private(set) var positions: [Position]
    
    /// Header Selected
    private(set) var selectedHeader: HeaderSelection
    
    /// Header reuse identifier
    var headerReuseIdentifier: String
    
    /// Header height
    var headerHeight: CGFloat
    
    /**
     Initializer 
     */
    init(_ category: Category) {
        self.name = category.name
        self.positions = category.positions
        self.headerReuseIdentifier = CategoryTableViewHeader.getReuseIdentifier()
        self.headerHeight = CategoryTableViewHeader.getHeight()
        self.selectedHeader = .unselected
    }
    
    /**
     Set selected header
     */
    open func setSelectedHeader(_ selected: HeaderSelection) {
        self.selectedHeader = selected
    }
    
    /**
     Get selected header
     */
    open func getSelectedHeader() -> HeaderSelection {
        return self.selectedHeader
    }
    
}
