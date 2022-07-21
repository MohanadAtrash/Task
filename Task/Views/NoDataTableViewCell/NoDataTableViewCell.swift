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
class NoDataTableViewCell: UITableViewCell {
    
    /// No data label
    @IBOutlet weak var noDataLabel: UILabel!
    
    /**
     Setup
     */
    func setup() {
        self.noDataLabel.text = "No data found!"
        self.isUserInteractionEnabled = false
    }
    
    /**
     Get no data table view cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "NoDataTableViewCell"
    }

    /**
     Get no data table view cell height
     */
    class func getHeight() -> CGFloat {
        return UIScreen.main.bounds.height - 190
    }
}
