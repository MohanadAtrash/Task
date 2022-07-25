//
//  BottomBiew.swift
//  Task
//
//  Created by Mohannad Al Atrash on 20/07/2022.
//

import UIKit

/**
 Bottom View
 */
class BottomView: UIScrollView {
    
    /// Selected categories label
    @IBOutlet weak var selectedCategoriesLabel: UILabel!
    /// Selected positions label
    @IBOutlet weak var selectedPositionsLabel: UILabel!
    /// Bottom view nib name
    let bottomViewNibName = "BottomView"
    
    /**
     Initializer
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    /**
     Required initializer
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    /**
     Common initializer
     */
    private func commonInit() {
        let bundle = Bundle.init(for: BottomView.self)
        if let viewToAdd = bundle.loadNibNamed("BottomView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.backgroundColor = UIColor(red: 0.000, green: 0.533, blue: 0.867, alpha: 1)
            contentView.layer.cornerRadius = 15
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.accessibilityScroll(.up)
        }
    }
    
}
