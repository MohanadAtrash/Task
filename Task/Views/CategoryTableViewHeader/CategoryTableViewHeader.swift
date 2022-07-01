//
//  CategoryTableViewHeader.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Category Table View Header
 */
class CategoryTableViewHeader: UITableViewHeaderFooterView {
    
    /// Header identifier
    private let identifier = "TableHeader"
    /// Header height
    private let height: CGFloat = 35
    /// Header Selected
    var selected: Bool = false
    

    /// Check button view
    let checkButtonView = UIButton(type: .custom)
    
    /// Category label
    let categoryLabel = UILabel()

    /// Expand and collapse button view
    let expandCollapseButtonView = UIButton(type: .custom)
    
    
    /**
     Header initializer
     */
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // Category setup
        self.categorySetup()
        // Add subviews
        self.addSubviews()
    }
    
    /**
     Header required initializer
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Category setup
     */
    func categorySetup() {
        self.checkButtonView.contentMode = .scaleAspectFit
        
        self.expandCollapseButtonView.contentMode = .scaleAspectFit
        
        self.categoryLabel.font = .systemFont(ofSize: 12, weight: .bold)
        self.categoryLabel.sizeToFit()
        self.categoryLabel.textAlignment = .left
    }
    
    /**
     Add subviews
     */
    func addSubviews() {
        self.contentView.addSubview(checkButtonView)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(expandCollapseButtonView)
    }
    
    /**
     Header layout subviews
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.checkButtonView.frame = CGRect(x: 13, y: 8, width: 14, height: 14)
        self.expandCollapseButtonView.frame = CGRect(x: contentView.frame.size.width - 30, y: 8, width: 14, height: 14)
        self.categoryLabel.frame = CGRect(x: (13 + self.checkButtonView.frame.size.width + 10), y: 8, width: (contentView.frame.size.width - (13 + self.checkButtonView.frame.size.width + 10 ) - (5 + self.expandCollapseButtonView.frame.size.width + 16)), height: self.checkButtonView.frame.size.height)
    }
    
    /**
     Set category name
     */
    func setCategoryName(_ name: String?) {
        self.categoryLabel.text = name
    }
    
    /**
     Set check button view
     */
    func setCheckButtonView(categoryHeader: CategoryTableViewHeaderRepresentable?) {
        if categoryHeader?.selected == true {
            self.checkButtonView.setImage(UIImage(named: "ThickSelectedCircleImage"), for: .normal)
        } else {
            self.checkButtonView.setImage(UIImage(named: "UnSelectedCircleImage"), for: .normal)
        }
    }
    
    /**
     Set expand collapse button view
     */
    func setExpandCollapseButtonView(categoryRepresentable: CategoryTableViewHeaderRepresentable?) {
        self.expandCollapseButtonView.setImage(UIImage(named: "DownUnfilledArrowImage"), for: .normal)
    }
    
    /**
     Get header height
     */
    class func getHeight() -> CGFloat {
        return CategoryTableViewHeader().height
    }
    
    /**
     Get header reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return CategoryTableViewHeader().identifier
    }
    
    /**
     Get selection
     */
    class func getSelection() -> Bool {
        return CategoryTableViewHeader().selected
    }
    
}
