//
//  IndicatorTableViewCellRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 03/07/2022.
//

import UIKit

/**
 Indicator Table View Cell Representable
 */
class IndicatorTableViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String
    
    /// Cell height
    var cellHeight: CGFloat
    
    
    /**
     Initializer
     */
    init() {
        self.cellReuseIdentifier = IndicatorTableViewCell.getReuseIdentifier()
        self.cellHeight = IndicatorTableViewCell.getHeight()
    }
}
