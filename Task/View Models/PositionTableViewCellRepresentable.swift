//
//  PositionTableViewCellRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 01/07/2022.
//

import UIKit

class PositionTableViewCellRepresentable {
    
    /// Position name
    var name: String
    
    /// Position id
    var id: Int
    
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
    }
}
