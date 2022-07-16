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
        if self.categoriesViewModel?.getTableSectionDataStatus() == true {
            if self.categoriesViewModel?.searching == true {
                if self.categoriesViewModel?.getSearchedRepresentablesCount() != 0 {
                    return (self.categoriesViewModel?.getSearchedRepresentablesCount())!
                } else {
                    return 1 // no data found
                }
            } else {
                return self.categoriesViewModel?.getCategoryRepresentablesCount() ?? 0
            }
        } else {
            return 1 // Indicator has one section
        }
    }
    
    /**
     Number of row in table view section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.categoriesViewModel?.getTableSectionDataStatus() == true {
            if self.categoriesViewModel?.searching == true && self.categoriesViewModel?.getSearchedRepresentablesCount() == 0 {
                self.categoryTableView.isScrollEnabled = false
                return 1 // no data found
            }
            self.searchBar.isHidden = false // show search bar
            self.categoryTableView.isScrollEnabled = true // enable scrolling for loading view
            if self.categoriesViewModel?.getTableSectionExpandedStatus(section: section) == true {
                return (self.categoriesViewModel?.getPositionRepresentablesCount(section: section))!
            } else {
                return 0
            }
        } else {
            self.searchBar.isHidden = true // hide search bar
            self.categoryTableView.isScrollEnabled = false // disable scrolling for loading view
            return 1 // Indicator cell
        }
    }
    
    /**
     Cell for row at index path
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.categoriesViewModel?.getTableSectionDataStatus() == true {
            if self.categoriesViewModel?.searching == true && self.categoriesViewModel?.getSearchedRepresentablesCount() == 0 {
                if let noDataTableViewCellRepresentable = noDataViewModel?.getNoDataTableViewCellRepresentable() as? NoDataTableViewCellRepresentable {
                    let cell = categoryTableView.dequeueReusableCell(withIdentifier: noDataTableViewCellRepresentable.cellReuseIdentifier, for: indexPath) as! NoDataTableViewCell
                    cell.setup(noDataTableViewCellRepresentable)
                    return cell
                }
            } else {
                if let positionTableViewCellRepresentable = categoriesViewModel?.getPositionRepresentable(index: indexPath) as? PositionTableViewCellRepresentable {
                    let cell = categoryTableView.dequeueReusableCell(withIdentifier: positionTableViewCellRepresentable.cellReuseIdentifier, for: indexPath) as! PositionTableViewCell
                    cell.setup(positionTableViewCellRepresentable)
                    return cell
                }
            }
        } else {
            if let indicatorTableViewCellRepresentable = indicatorViewModel?.getIndicatorTableViewCellRepresentable() as? IndicatorTableViewCellRepresentable {
                let cell = categoryTableView.dequeueReusableCell(withIdentifier: indicatorTableViewCellRepresentable.cellReuseIdentifier, for: indexPath) as! IndicatorTableViewCell
                cell.setup()
                return cell
            }
        }
        return UITableViewCell()
    }
    
    /**
     View for header in table view section
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 5
        tableView.sectionFooterHeight = 0
        if self.categoriesViewModel?.getTableSectionDataStatus() == true {
            if self.categoriesViewModel?.searching == true && self.categoriesViewModel?.getSearchedRepresentablesCount() == 0 {
                return UIView()
            }
            if let sectionRepresentable = self.categoriesViewModel?.getSectionRepresentable(section) as? TableSectionRepresentable {
                if let headerRepresentable = self.categoriesViewModel?.getCategoryRepresentable(section: section) as? CategoryTableViewHeaderRepresentable {
                    let header = categoryTableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryTableViewHeader.getReuseIdentifier()) as! CategoryTableViewHeader
                    header.checkButtonView.addTarget(self, action: #selector(headerTapped(button:)), for: .touchUpInside)
                    header.expandCollapseButtonView.addTarget(self, action: #selector(expandCollapseTapped(button:)), for: .touchUpInside)
                    header.setup(headerRepresentable, sectionRepresentable, at: section)
                    return header
                }
            }
        }
        return UIView()
    }
    
    /**
     Header expand collapse button tapped
     */
    @objc func expandCollapseTapped(button: UIButton) {
        let section = button.tag
        self.categoriesViewModel?.getSectionRepresentable(section).isExpanded = !(self.categoriesViewModel?.getSectionRepresentable(section).isExpanded)!
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
        if self.categoriesViewModel?.getTableSectionDataStatus() == true {
            if self.categoriesViewModel?.searching == true && self.categoriesViewModel?.getSearchedRepresentablesCount() == 0  {
                return 0
            }
            return self.categoriesViewModel?.getCategoryRepresentableHeight(section: section) ?? 0
        }
        return 0
    }
    
    /**
     Table cell height for row at index path
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.categoriesViewModel?.getTableSectionDataStatus() == true {
            if self.categoriesViewModel?.searching == true && self.categoriesViewModel?.getSearchedRepresentablesCount() == 0  {
                return self.noDataViewModel?.getNoDataRepresentableHeight() ?? 0
            }
            return self.categoriesViewModel?.getPositionRepresentableHeight(index: indexPath) ?? 0
        } else {
            return self.indicatorViewModel?.getIndicatorRepresentableHeight() ?? 0
        }
    }

}
