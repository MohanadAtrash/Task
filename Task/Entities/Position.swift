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
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
    /**
     Initializer
     */
    init(_ dictionary: [String: Any]) {
        self.name = dictionary[CodingKeys.name.rawValue] as! String
        self.id = dictionary[CodingKeys.id.rawValue] as! Int
    }
}
