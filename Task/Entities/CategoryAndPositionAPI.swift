//
//  CategoryAndPositionsJSON.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit

/**
 Response
 */
struct Response: Decodable {
    let data: [Result]
    let status: String
    let status_code: Int
}

/**
 Result
 */
struct Result: Decodable {
    let PositionType: Categories
}

/**
 Categories
 */
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

/**
 Positions
 */
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

/**
 Position Type
 */
struct PositionType: Decodable {
    let code: String
    let id: Int
    let name: String
}

