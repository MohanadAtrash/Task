//
//  PositionTableViewCell.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Position Table View Cell
 */
class PositionTableViewCell: UITableViewCell {
    
    /// Check  Image View
    @IBOutlet private weak var checkImageView: UIImageView!
    /// Name Label
    @IBOutlet private weak var nameLabel: UILabel!
    /// Cell Reuse Identifier
    private let cellReuseIdentifier: String = "PositionTableViewCell"
    
    /**
     Position table view cell setup
     */
    func setupPosition(_ position: PositionTableViewCellRepresentable) {
        self.nameLabel.text = position.name
        self.checkImageView.image = UIImage(named: "UnSelectedCircleImage")
    }
    
    /**
     Get table view cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return PositionTableViewCell().cellReuseIdentifier
    }

    /**
     Get table view cell height
     */
    class func getHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
