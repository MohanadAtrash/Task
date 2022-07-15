//
//  CategoryAndPositionModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit
import Alamofire

/// Category  Model
class CategoryModel {
    
    /**
     Get categories
     */
    class func getCategories(completion: @escaping ([Category]) -> Void) {
        
        var categories = [Category]()
        AF.request(CategoryAndPositionRouter.getCategoryAndPosition).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let data = json["data"] as! [Any]
                for positionType in data {
                    let listOfCategories = positionType as! [String: Any]
                    let category = listOfCategories["PositionType"] as! [String: Any]
                    
                    let categoryName = category["name"] as! String
                    let categoryId = category["id"] as! Int
                    
                    let listOfPositions = category["Position"] as! [Any]
                    var categoryPositions = [Position]()
                    for positions in listOfPositions[0...5] {
                        let position = positions as! [String: Any]
                        let positionName = position["name"] as! String
                        let positionId = position["id"] as! Int
                        categoryPositions.append(Position(name: positionName, id: positionId))
                    }
                    categories.append(Category(name: categoryName, id: categoryId, positions: categoryPositions))
                }
            case .failure(let error):
                print("Error in parsing data: \(error)")
            }
            completion(categories)
        }
    }
}
