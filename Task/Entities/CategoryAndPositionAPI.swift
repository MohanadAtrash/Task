//
//  CategoryAndPositionsJSON.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

struct Response: Decodable {
    let data: [Result]
    let status: String
    let status_code: Int
}

struct Result: Decodable {
    let PositionType: Categories
}

struct Categories: Decodable {
    let Position: [Positions]
    let name: String? // category name
    let code: String? // caegory id
    let id: Int
    
//    enum codingKeys: String, CodingKey {
//        case categoryName = "name"
//        case categoryId = "id"
//    }
}

struct Positions: Decodable {
    let code: String
    let id: Int // position id
    let name: String // position name
    let position_type: PositionType
    let status: String
    
//    enum codingKeys: String, CodingKey {
//        case positionName = "name"
//        case positionId = "id"
//    }
}

struct PositionType: Decodable {
    let code: String
    let id: Int
    let name: String
}

