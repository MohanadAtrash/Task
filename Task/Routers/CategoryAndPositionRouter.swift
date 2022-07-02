//
//  CategoryAndPositionRouter.swift
//  Task
//
//  Created by Mohannad Al Atrash on 29/06/2022.
//

import UIKit
import Alamofire

/**
 Category And Position Router
 */
enum CategoryAndPositionRouter: URLRequestConvertible {
        
    // Get categories method
    case getCategoryAndPosition
    
    // Base url
    var baseURLString: URL {
        return URL(string: "https://gateway.harridev.com/core/api/v1")!
    }
    
    // HTTP request method
    var method: HTTPMethod {
        switch self {
            case .getCategoryAndPosition:
                return .get
        }
    }
    
    // URL path
    var path: String {
        switch self {
            case .getCategoryAndPosition: return "/category_positions"
        }
    }
    
    /**
    As URL request method that returns a request
    */
    func asURLRequest() throws -> URLRequest {
        let url = baseURLString.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
    
}
    


