//
//  Table.swift
//  Task
//
//  Created by Mohannad Al Atrash on 05/07/2022.
//

import UIKit

/**
 Table View Cell Protocol
 */
protocol TableViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String { set get }
    
    /// Cell height
    var cellHeight: CGFloat { set get }
    
}
