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
class NoDataTableViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String
    
    /// Cell height
    var cellHeight: CGFloat
    
    /// No data message
    var message: String
    
    /**
     Initializer
     */
    init(_ message: String) {
        self.cellReuseIdentifier = NoDataTableViewCell.getReuseIdentifier()
        self.cellHeight = NoDataTableViewCell.getHeight()
        self.message = message
    }
}
