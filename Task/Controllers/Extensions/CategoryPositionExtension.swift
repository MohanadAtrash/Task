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
        return self.categoriesViewModel?.getPositionRepresentablesCount(section: section) ?? 0
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
        
        let header = categoryTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CategoryTableViewHeader
        
        header.setCategoryName((categoriesViewModel?.getCategoryRepresentable(section: section).name)!)
        header.setCheckButtonView((categoriesViewModel?.getCategoryRepresentable(section: section))!)

        header.checkButtonView.tag = section
        header.checkButtonView.addTarget(self, action: #selector(headerTapped(button:)), for: .touchUpInside)

        header.expandCollapseButtonView.tag = section
        header.expandCollapseButtonView.addTarget(self, action: #selector(expandCollapseTapped(button:)), for: .touchUpInside)
        
        return header
    }
    
    @objc func expandCollapseTapped(button: UIButton) {
        print("chech header tapped at \(button.tag)")

        self.categoryTableView.reloadData()
    }
    
    @objc func headerTapped(button: UIButton) {
        print("expand header tapped at \(button.tag)")
        self.categoryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell \(indexPath.section) , \(indexPath.row) is selected!")
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
