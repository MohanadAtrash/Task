//
//  NoDataTableViewCell.swift
//  Task
//
//  Created by Mohannad Al Atrash on 07/07/2022.
//

import UIKit

/**
 No Data Table View Cell
 */
class NoDataTableViewCell: UITableViewCell, TableViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String = "NoDataTableViewCell"
    
    /// Cell height
    var cellHeight: CGFloat = UIScreen.main.bounds.height - 150
    
    /// No data label
    @IBOutlet weak var noDataLabel: UILabel!
    
    /**
     Setup
     */
    func setup(_ noDataRepresentable: NoDataTableViewCellRepresentable) {
        self.noDataLabel.text = noDataRepresentable.message
        self.isUserInteractionEnabled = false
    }
    
    /**
     Get no data table view cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return NoDataTableViewCell().cellReuseIdentifier
    }

    /**
     Get no data table view cell height
     */
    class func getHeight() -> CGFloat {
        return NoDataTableViewCell().cellHeight
    }
}
