//
//  CategoryPositionExtension.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

extension CategoryAndPositionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoriesViewModel?.getCategoryRepresentablesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.categoriesViewModel?.getTableSectionExpanded(section: section) == true {
            return (self.categoriesViewModel?.getPositionRepresentablesCount(section: section))!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let positionTableViewCellRepresentable = categoriesViewModel?.getPositionRepresentable(index: indexPath) as? PositionTableViewCellRepresentable {
            let cell = categoryTableView.dequeueReusableCell(withIdentifier: positionTableViewCellRepresentable.cellReuseIdentifier, for: indexPath) as! PositionTableViewCell
                cell.setupPosition(positionTableViewCellRepresentable)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let categoryTableViewHeaderRepresentable = categoriesViewModel?.getCategoryRepresentable(section: section) as? CategoryTableViewHeaderRepresentable {
            let header = categoryTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CategoryTableViewHeader
                
            header.setCategoryName(categoriesViewModel?.getCategoryRepresentable(section: section)?.name)
            header.setCheckButtonView(categoryHeader: categoriesViewModel?.getCategoryRepresentable(section: section))

            header.checkButtonView.tag = section
            header.checkButtonView.addTarget(self, action: #selector(headerTapped(button:)), for: .touchUpInside)

            header.setExpandCollapseButtonView(categoryRepresentable: categoryTableViewHeaderRepresentable)
            header.expandCollapseButtonView.tag = section
            header.expandCollapseButtonView.addTarget(self, action: #selector(expandCollapseTapped(button:)), for: .touchUpInside)
            return header
        }
        return UIView()
    }
    
    @objc func expandCollapseTapped(button: UIButton) {
        let section = button.tag
        self.categoriesViewModel?.representables[section].isExpanded = !(self.categoriesViewModel?.representables[section].isExpanded)!
        self.categoryTableView.reloadData()
    }
    
    @objc func headerTapped(button: UIButton) {
        let section = button.tag
        self.categoriesViewModel?.getCategoryRepresentable(section: section)?.selected = !(self.categoriesViewModel?.getCategoryRepresentable(section: section)!.selected)!
        self.categoryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoriesViewModel?.getPositionRepresentable(index: indexPath).selectedCell = !(self.categoriesViewModel?.getPositionRepresentable(index: indexPath).selectedCell)!
        tableView.reloadData()
    }
    
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
