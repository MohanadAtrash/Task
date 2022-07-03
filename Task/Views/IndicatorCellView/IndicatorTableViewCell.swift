//
//  IndicatorTableViewCell.swift
//  Task
//
//  Created by Mohannad Al Atrash on 03/07/2022.
//

import UIKit

/**
 Indicator Table View Cell
 */
class IndicatorTableViewCell: UITableViewCell {

    /// Indicator View
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    /// Cell reuse identifier
    private let cellReuseIdentifier: String = "IndicatorTableViewCell"
    
    /**
     Setup For Indicator Table View Cell
     */
    func setup() {
        self.indicatorView.style = .large
        self.indicatorView.color = UIColor(red: 0.000, green: 0.533, blue: 0.867, alpha: 1)
        self.indicatorView.startAnimating()
    }
    
    /**
     Get indicator table view cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return IndicatorTableViewCell().cellReuseIdentifier
    }

    /**
     Get indicator table view cell height
     */
    class func getHeight() -> CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    
}
