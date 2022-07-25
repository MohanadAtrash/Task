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
     Coding keys
     */
    enum codingKeys: String, CodingKey {
        case data = "data"
        case positionType = "PositionType"
        case position = "Position"
    }
    
    /**
     Get categories
     */
    class func getCategories(completion: @escaping ([Category]) -> Void) {
        
        var categories = [Category]()
        
        AF.request(CategoryAndPositionRouter.getCategoryAndPosition).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    if let data = json[codingKeys.data.rawValue] as? [Any] {
                        for positionType in data {
                            if let listOfCategories = positionType as? [String: Any] {
                                var categoryDictionary = listOfCategories[codingKeys.positionType.rawValue] as! [String: Any]
                                let listOfPositions = categoryDictionary[codingKeys.position.rawValue] as! [Any]
                                var positions = [Position]()
                                
                                for position in listOfPositions {
                                    let positionDictionary = position as! [String: Any]
                                    positions.append(Position(positionDictionary))
                                }
                                categoryDictionary[Category.codingKeys.positions.rawValue] = positions
                                categories.append(Category(categoryDictionary))
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Error in parsing data: \(error)")
            }
            completion(categories)
        }
    }
}
