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
        
        if let _ = self.categoriesViewModel?.getTableSectionRepresentable(section) {
            if let tableViewCellRepresentables = self.categoriesViewModel?.getTableViewCellRepresentables(section) {
                if tableViewCellRepresentables is [PositionTableViewCellRepresentable] {
                    self.searchBar.isHidden = false // show search bar
                    self.categoryTableView.isScrollEnabled = true // enable scrolling for loading view
                    if self.categoriesViewModel?.getTableSectionExpandedStatus(section) == true { // If expanded
                        return tableViewCellRepresentables.count
                    } else { // Not expanded
                        return 0
                    }
                }
                
                if tableViewCellRepresentables is [NoDataTableViewCellRepresentable] {
                    self.categoryTableView.isScrollEnabled = false // disable scrolling for loading view
                    return tableViewCellRepresentables.count
                }
                
                if tableViewCellRepresentables is [IndicatorTableViewCellRepresentable] {
                    self.searchBar.isHidden = true // hide search bar
                    self.categoryTableView.isScrollEnabled = false // disable scrolling for loading view
                    return tableViewCellRepresentables.count
                }
            }
        }
        return 0
    }
    
    /**
     Cell for row at index path
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellRepresentable = self.categoriesViewModel?.getTableViewCellRepresentable(indexPath) {
            switch cellRepresentable {
            case is PositionTableViewCellRepresentable:
                let cell = categoryTableView.dequeueReusableCell(withIdentifier: cellRepresentable.cellReuseIdentifier, for: indexPath) as! PositionTableViewCell
                cell.setup(cellRepresentable as! PositionTableViewCellRepresentable)
                return cell
            case is IndicatorTableViewCellRepresentable:
                let cell = categoryTableView.dequeueReusableCell(withIdentifier: cellRepresentable.cellReuseIdentifier, for: indexPath) as! IndicatorTableViewCell
                cell.setup()
                return cell
            case is NoDataTableViewCellRepresentable:
                let cell = categoryTableView.dequeueReusableCell(withIdentifier: cellRepresentable.cellReuseIdentifier, for: indexPath) as! NoDataTableViewCell
                cell.setup()
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    /**
     View for header in table view section
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sectionRepresentable = self.categoriesViewModel?.getTableSectionRepresentable(section) as? TableSectionRepresentable {
            if let headerRepresentable = self.categoriesViewModel?.getTableViewHeaderRepresentable(section) as? CategoryTableViewHeaderRepresentable {
                let header = categoryTableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryTableViewHeader.getReuseIdentifier()) as! CategoryTableViewHeader
                header.checkButtonView.addTarget(self, action: #selector(headerTapped(button:)), for: .touchUpInside)
                header.expandCollapseButtonView.addTarget(self, action: #selector(expandCollapseTapped(button:)), for: .touchUpInside)
                header.setup(headerRepresentable, sectionRepresentable, at: section)
                tableView.sectionHeaderTopPadding = 5
                tableView.sectionFooterHeight = 0
                return header
            }
        }
        return UIView()
    }
    
    /**
     Header expand collapse button tapped
     */
    @objc func expandCollapseTapped(button: UIButton) {
        let section = button.tag // Section tapped
        if let sectionRepresentable = self.categoriesViewModel?.getTableSectionRepresentable(section) as? TableSectionRepresentable {
            sectionRepresentable.toggleIsExpanded()
            self.categoryTableView.reloadData()
        }
    }
    
    /**
     Header check button tapped
     */
    @objc func headerTapped(button: UIButton) {
        let section = button.tag
        if let categoryHeaderRepresentable = self.categoriesViewModel?.getTableViewHeaderRepresentable(section) as? CategoryTableViewHeaderRepresentable {
            if categoryHeaderRepresentable.selectedHeader == .selected {
                categoryHeaderRepresentable.setSelectedHeader(.unselected)
                self.categoriesViewModel?.unselectPositionTableViewCellRepresentables(section)
            } else {
                categoryHeaderRepresentable.setSelectedHeader(.selected)
                self.categoriesViewModel?.selectPositionTableViewCellRepresentables(section)
            }
            self.saveTableViewStatus(section)
            self.categoryTableView.reloadData()
            self.bottomViewLogicSetup()
        }
    }
    
    func saveTableViewStatus(_ section: Int) {
        if let category = self.categoriesViewModel?.getCategory(section) { // Save status for categories and postions
            if let categoryTableViewHeaderRepresentable = self.categoriesViewModel?.getTableViewHeaderRepresentable(section) as? CategoryTableViewHeaderRepresentable {
                if categoryTableViewHeaderRepresentable.selectedHeader == .selected {
                    self.categoriesViewModel?.selectedCategories[category] = self.categoriesViewModel?.getPositionsAtSection(section)
                } else if categoryTableViewHeaderRepresentable.selectedHeader == .unselected {
                    self.categoriesViewModel?.selectedCategories[category] = nil
                } else { // partially
                    self.categoriesViewModel?.selectedCategories[category] = []
                    if let positionTableViewCellRepresentables = self.categoriesViewModel?.getTableViewCellRepresentables(section) as? [PositionTableViewCellRepresentable] {
                        for index in positionTableViewCellRepresentables.indices {
                            if let position = self.categoriesViewModel?.getPositionIfSelected(IndexPath(row: index, section: section)) {
                                self.categoriesViewModel?.selectedCategories[category]?.append(position)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /**
     Did select row at index path
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let positionTableViewCellRepresentable = self.categoriesViewModel?.getTableViewCellRepresentable(indexPath) as? PositionTableViewCellRepresentable { // Position representable
            positionTableViewCellRepresentable.toggleSelectedCell()
            if let tableViewHeaderRepresentable = self.categoriesViewModel?.getTableViewHeaderRepresentable(indexPath.section) as? CategoryTableViewHeaderRepresentable { // Set header selection
                if self.categoriesViewModel?.checkPositionsSelections(indexPath) == .selected {
                    tableViewHeaderRepresentable.setSelectedHeader(.selected)
                } else if self.categoriesViewModel?.checkPositionsSelections(indexPath) == .unselected {
                    tableViewHeaderRepresentable.setSelectedHeader(.unselected)
                } else {
                    tableViewHeaderRepresentable.setSelectedHeader(.partiallySelected)
                }
                
                self.saveTableViewStatus(indexPath.section)
            }
            tableView.reloadData()
            self.bottomViewLogicSetup()
        }
    }
    
    /**
     Height for header in table view section
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let headerRepresentable = self.categoriesViewModel?.getTableViewHeaderRepresentable(section) as? CategoryTableViewHeaderRepresentable {
            return headerRepresentable.headerHeight
        }
        return 0
    }
    
    /**
     Table cell height for row at index path
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let cellRepresentable = self.categoriesViewModel?.getTableViewCellRepresentable(indexPath) {
            return cellRepresentable.cellHeight
        }
        return 0
    }
}
