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
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case positions = "positions"
    }
    
    /**
     Initializer
     */
    init(_ dictionary: [String: Any]) {
            self.name = dictionary[CodingKeys.name.rawValue] as! String
            self.id = dictionary[CodingKeys.id.rawValue] as! Int
            self.positions = dictionary[CodingKeys.positions.rawValue] as! [Position]
    }
}

