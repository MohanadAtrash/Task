//
//  Position.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Position
 */
struct Position: Decodable, Hashable {
    
    /// Name
    var name: String
    /// Id
    var id: Int
    
    /**
     Coding keys
     */
    enum codingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
    /**
     Initializer
     */
    init(_ dictionary: [String: Any]) {
        self.name = dictionary[codingKeys.name.rawValue] as! String
        self.id = dictionary[codingKeys.id.rawValue] as! Int
    }
}
