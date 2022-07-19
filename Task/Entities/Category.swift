//
//  Category.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Category
 */
struct Category: Decodable, Hashable {
    
    /// Name
    var name: String
    /// Id
    var id: Int
    /// Positions
    var positions: [Position]
    
    /**
     Coding keys
     */
    enum codingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case positions = "positions"
    }
    
    /**
     Initializer
     */
    init(_ dictionary: [String: Any]) {
            self.name = dictionary[codingKeys.name.rawValue] as! String
            self.id = dictionary[codingKeys.id.rawValue] as! Int
            self.positions = dictionary[codingKeys.positions.rawValue] as! [Position]
    }
}

