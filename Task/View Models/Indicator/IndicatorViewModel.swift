//
//  IndicatorViewModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 03/07/2022.
//

import UIKit

/**
 Indicator View Model
 */
class IndicatorViewModel {
    
    /// Representable
    var representable: IndicatorTableViewCellRepresentable
    
    /**
     Initializer
     */
    init() {
        self.representable = IndicatorTableViewCellRepresentable()
    }
    
    /**
     Get indicator table view cell representable
     */
    func getIndicatorTableViewCellRepresentable() -> IndicatorTableViewCellRepresentable? {
        return self.representable
    }
    
    /**
     Get indicator representable height
    */
    func getIndicatorRepresentableHeight() -> CGFloat {
        return self.representable.cellHeight
    }
}
