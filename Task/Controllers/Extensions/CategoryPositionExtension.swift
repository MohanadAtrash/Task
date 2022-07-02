//
//  CategoryPositionExtension.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Category And Position View Controller Extension
 */
extension CategoryAndPositionViewController: UITableViewDelegate, UITableViewDataSource {
    
    /**
     Number of sections in table view
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoriesViewModel?.getCategoryRepresentablesCount() ?? 0
    }
    
    /**
     Number of row in table view section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.categoriesViewModel?.getTableSectionExpanded(section: section) == true {
            return (self.categoriesViewModel?.getPositionRepresentablesCount(section: section))!
        }
        return 0
    }
    
    /**
     Cell for row at index path
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let positionTableViewCellRepresentable = categoriesViewModel?.getPositionRepresentable(index: indexPath) as? PositionTableViewCellRepresentable {
            let cell = categoryTableView.dequeueReusableCell(withIdentifier: positionTableViewCellRepresentable.cellReuseIdentifier, for: indexPath) as! PositionTableViewCell
                cell.setupPosition(positionTableViewCellRepresentable)
            return cell
        }
        return UITableViewCell()
    }
    
    /**
     View for header in table view section
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 5
        tableView.sectionFooterHeight = 0
        if let _ = categoriesViewModel?.getCategoryRepresentable(section: section) as? CategoryTableViewHeaderRepresentable {
            let header = categoryTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CategoryTableViewHeader
                
            header.setCategoryName(categoriesViewModel?.getCategoryRepresentable(section: section)?.name)
            header.setCheckButtonView(categoryHeader: categoriesViewModel?.getCategoryRepresentable(section: section))

            header.checkButtonView.tag = section
            header.checkButtonView.addTarget(self, action: #selector(headerTapped(button:)), for: .touchUpInside)

            header.setExpandCollapseButtonView(sectionRepresentable: categoriesViewModel?.representables[section])
            header.expandCollapseButtonView.tag = section
            header.expandCollapseButtonView.addTarget(self, action: #selector(expandCollapseTapped(button:)), for: .touchUpInside)
            return header
        }
        return UIView()
    }
    
    /**
     Header expand collapse button tapped
     */
    @objc func expandCollapseTapped(button: UIButton) {
        let section = button.tag
        self.categoriesViewModel?.representables[section].isExpanded = !(self.categoriesViewModel?.representables[section].isExpanded)!
        self.categoryTableView.reloadData()
    }
    
    /**
     Header check button tapped
     */
    @objc func headerTapped(button: UIButton) {
        let section = button.tag
        let selected = self.categoriesViewModel?.getCategoryRepresentable(section: section)?.selectedHeader
        if selected == .selected {
            self.categoriesViewModel?.getCategoryRepresentable(section: section)?.selectedHeader = .unselected
            self.categoriesViewModel?.unselectPositionRepresentables(at: section)
        } else {
            self.categoriesViewModel?.getCategoryRepresentable(section: section)?.selectedHeader = .selected
            self.categoriesViewModel?.selectPositionRepresentables(at: section)
        }
        self.categoryTableView.reloadData()
    }
    
    /**
     Did select row at index path
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoriesViewModel?.getPositionRepresentable(index: indexPath).selectedCell = !(self.categoriesViewModel?.getPositionRepresentable(index: indexPath).selectedCell)!
        if self.categoriesViewModel?.checkPositionsSelections(index: indexPath) == .selected {
            self.categoriesViewModel?.getCategoryRepresentable(section: indexPath.section)?.selectedHeader = .selected
        } else if self.categoriesViewModel?.checkPositionsSelections(index: indexPath) == .unselected {
            self.categoriesViewModel?.getCategoryRepresentable(section: indexPath.section)?.selectedHeader = .unselected
        } else {
            self.categoriesViewModel?.getCategoryRepresentable(section: indexPath.section)?.selectedHeader = .partiallySelected
        }
        tableView.reloadData()
    }
    
    /**
     Height for header in table view section
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.categoriesViewModel?.getCategoryRepresentableHeight(section: section) ?? 0
    }
    
    /**
     Table cell height for row at index path
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.categoriesViewModel?.getPositionRepresentableHeight(index: indexPath) ?? 0
    }

}
