//
//  CategoryAndPositionModel.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit
import Alamofire

/// Category And Position Model
class CategoryAndPositionModel {
    
    /**
     Get categories and positions
     */
    class func getCategories(completion: @escaping ([Category]) -> Void) {
        
        var categories = [Category]()
        var positions = [Position]()
        
        AF.request(CategoryAndPositionRouter.getCategoryAndPosition).responseJSON { response in
            print(response.response!.statusCode)
            guard let data = response.data else { return }
            print("Data is : \(data)")
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch let jsonError {
                print("Failed to decode:  \(jsonError)")
            }
            guard let final = result else { return }
            
            for index1 in final.data.indices { // no need !
                for index in final.data[index1].PositionType.Position.indices[0...5] { // add all positions
                    positions.append(Position(name: final.data[index1].PositionType.Position[index].name, id: final.data[index1].PositionType.Position[index].id))
                }
                categories.append(Category(name: final.data[index1].PositionType.name!, id: final.data[index1].PositionType.id, positions: positions))
                positions.removeAll()
            }
            completion(categories)
        }
    }
}
