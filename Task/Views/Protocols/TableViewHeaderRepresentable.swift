//
//  TableViewHeaderRepresentable.swift
//  Task
//
//  Created by Mohannad Al Atrash on 18/07/2022.
//

import UIKit

/**
 Table view header representable
 */
protocol TableViewHeaderRepresentable {
    
    /// Header height
    var headerHeight: CGFloat { set get }
    
    /// header reuse identifier
    var headerReuseIdentifier: String { set get }

}
