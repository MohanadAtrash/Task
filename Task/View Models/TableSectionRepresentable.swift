//
//  TableSectionRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 01/07/2022.
//

import UIKit

/**
 Table Section Representable
 */
class TableSectionRepresentable {
    
    /// Section header representable
    var sectionHeaderRepresentable: CategoryTableViewHeaderRepresentable?
    
    /// Cells representables
    var cellsRepresentables: [PositionTableViewCellRepresentable]
    
    /// Is expanded
    var isExpanded: Bool
    
    /**
     Initilizer
     */
    init() {
        self.sectionHeaderRepresentable = nil
        self.cellsRepresentables = []
        self.isExpanded = false
    }
}
