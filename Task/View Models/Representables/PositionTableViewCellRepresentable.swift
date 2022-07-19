//
//  PositionTableViewCellRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 01/07/2022.
//

import UIKit

/**
 Position Table View Cell Representable
 */
class PositionTableViewCellRepresentable: TableViewCellRepresentable {
    
    /// Position name
    private(set) var name: String
    
    /// Position id
    private(set) var id: Int
    
    /// Selected cell
    private(set) var selectedCell: Bool
    
    /// Cell height
    var cellHeight: CGFloat
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String
    
    /**
     Initializer of position cell representable
     */
    init(_ position: Position) {
        self.name = position.name
        self.id = position.id
        self.cellReuseIdentifier = PositionTableViewCell.getReuseIdentifier()
        self.cellHeight = PositionTableViewCell.getHeight()
        self.selectedCell = false
    }
    
    /**
     Set selected cell
     */
    open func setSelectedCell(_ selected: Bool) {
        self.selectedCell = selected
    }
    
    /**
     Toggle selected cell
     */
    open func toggleSelectedCell() {
        self.selectedCell = !self.selectedCell
    }
}
