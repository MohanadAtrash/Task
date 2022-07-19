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
        self.categorySubviewsSetup()
        // Add subviews
        self.addSubviews()
    }
    
    /**
     Header setup
     */
    func setup(_ header: CategoryTableViewHeaderRepresentable, _ sectionRepresentable: TableSectionRepresentable, at section: Int) {
        self.categoryLabel.text = header.name
        if header.selectedHeader == .selected {
            self.setCheckButtonView(categoryHeader: header)
            
        } else if header.selectedHeader == .unselected {
            self.setCheckButtonView(categoryHeader: header)
        } else {
            self.setCheckButtonView(categoryHeader: header)
        }
        
        self.setExpandCollapseButtonView(sectionRepresentable: sectionRepresentable)
        self.checkButtonView.tag = section
        self.expandCollapseButtonView.tag = section

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
    private func categorySubviewsSetup() {
        self.checkButtonView.contentMode = .scaleAspectFit
        self.expandCollapseButtonView.contentMode = .scaleAspectFill
        self.categoryLabel.font = .systemFont(ofSize: 12, weight: .bold)
        self.categoryLabel.sizeToFit()
        self.categoryLabel.textAlignment = .left
    }
    
    /**
     Add subviews
     */
    private func addSubviews() {
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
        self.expandCollapseButtonView.frame = CGRect(x: contentView.frame.size.width - 30, y: 8, width: 18, height: 16)
        self.categoryLabel.frame = CGRect(x: (13 + self.checkButtonView.frame.size.width + 10), y: 7, width: (contentView.frame.size.width - (13 + self.checkButtonView.frame.size.width + 10 ) - (5 + self.expandCollapseButtonView.frame.size.width + 16)), height: self.contentView.frame.size.height - 18)
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
        if categoryHeader?.selectedHeader == .selected {
            self.checkButtonView.setImage(UIImage(named: "ThickSelectedCircleImage"), for: .normal)
        } else if categoryHeader?.selectedHeader == .unselected {
            self.checkButtonView.setImage(UIImage(named: "UnSelectedCircleImage"), for: .normal)
        } else {
            self.checkButtonView.setImage(UIImage(named: "PartialSelectionImage"), for: .normal)
        }
    }
    
    /**
     Set expand collapse button view
     */
    func setExpandCollapseButtonView(sectionRepresentable: TableSectionRepresentable?) {
        if sectionRepresentable?.isExpanded == true {
            self.expandCollapseButtonView.setImage(UIImage(named: "UpUnfilledArrowImage"), for: .normal)
        } else {
            self.expandCollapseButtonView.setImage(UIImage(named: "DownUnfilledArrowImage"), for: .normal)
        }
    }
    
    /**
     Get header height
     */
    class func getHeight() -> CGFloat {
        return 35
    }
    
    /**
     Get header reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "TableHeader"
    }
    
}
