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
    var sectionHeaderRepresentable: TableViewHeaderRepresentable?
    
    /// Cells representables
    var cellsRepresentables: [TableViewCellRepresentable]
    
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
    
    /**
     Toggle is expanded
     */
    func toggleIsExpanded() {
        self.isExpanded = !self.isExpanded
    }
}
