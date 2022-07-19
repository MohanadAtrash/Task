//
//  NoDataTableViewCellRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 07/07/2022.
//

import UIKit

/**
 No Dara Table View Cell Representable
 */
class NoDataTableViewCellRepresentable: TableViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String
    
    /// Cell height
    var cellHeight: CGFloat
    
    /**
     Initializer
     */
    init() {
        self.cellReuseIdentifier = NoDataTableViewCell.getReuseIdentifier()
        self.cellHeight = NoDataTableViewCell.getHeight()
    }
}
