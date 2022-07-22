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
    
    /// Table view header representable
    var tableViewHeaderRepresentable: TableViewHeaderRepresentable?
    
    /// Table view cell representables
    var tableViewCellRepresentables: [TableViewCellRepresentable]
    
    /// Is expanded
    var isExpanded: Bool
    
    /**
     Initilizer
     */
    init() {
        self.tableViewHeaderRepresentable = nil
        self.tableViewCellRepresentables = []
        self.isExpanded = false
    }
    
    /**
     Toggle is expanded
     */
    func toggleIsExpanded() {
        self.isExpanded = !self.isExpanded
    }
}
