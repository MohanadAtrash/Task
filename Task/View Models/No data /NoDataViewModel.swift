//
//  NoDataViewModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 07/07/2022.
//

import UIKit

/**
 No Data View Model
 */
class NoDataViewModel {
    
    /// Representable
    var representable: NoDataTableViewCellRepresentable
    
    /// Message
    var message: String = "No data found!"
    
    /**
     Initializer
     */
    init() {
        self.representable = NoDataTableViewCellRepresentable(message)
    }
    
    /**
     Get no data table view cell representable
     */
    func getNoDataTableViewCellRepresentable() -> NoDataTableViewCellRepresentable? {
        return self.representable
    }
    
    /**
     Get no data representable height
    */
    func getNoDataRepresentableHeight() -> CGFloat {
        return self.representable.cellHeight
    }
    
}
