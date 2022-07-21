//
//  BottomBiew.swift
//  Task
//
//  Created by Mohannad Al Atrash on 20/07/2022.
//

import UIKit

class BottomView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var selectedCategoriesLabel: UILabel!
    @IBOutlet weak var selectedPositionsLabel: UILabel!
    
    let bottomViewIdentifier = "BottomView"
    
    func setup() {
        self.selectedPositionsLabel.text = ""
        self.selectedCategoriesLabel.text = ""
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.selectedCategoriesLabel.numberOfLines = 1
        self.selectedPositionsLabel.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        self.setup()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(bottomViewIdentifier, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
}

extension UIView {
    
    func fixInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 2).isActive = true
    }
}
