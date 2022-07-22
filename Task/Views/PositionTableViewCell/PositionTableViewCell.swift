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
    
    /// Check  image view
    @IBOutlet private weak var checkImageView: UIImageView!
    
    /// Name label
    @IBOutlet private weak var nameLabel: UILabel!
    
    /**
     Setup
     */
    func setup(_ position: PositionTableViewCellRepresentable) {
        self.isUserInteractionEnabled = true
        self.nameLabel.text = position.name
        if position.selectedCell {
            self.checkImageView.image = UIImage(named: "ThickSelectedCircleImage")
        } else {
            self.checkImageView.image = UIImage(named: "UnSelectedCircleImage")
        }
    }
    
    /**
     Get reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "PositionTableViewCell"
    }

    /**
     Get height
     */
    class func getHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
