//
//  NetworkRouter.swift
//  NaverSearch
//
//  Created by 차지용 on 8/13/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case shop(searchTitle: String, sort: String, start: Int)
    case mac(sort: String, start: Int)

    var baseURL: String {
        return "\(NaverURL.url.rawValue)v1/search/shop.json?"
    }
    var endpoint: URL {
        switch self {
        case .shop(let searchTitle, let sort, let start):
            return URL(string: baseURL + "query=\(searchTitle)&display=100&start=\(start)&sort=\(sort)")!
        case .mac(let sort, let start):
            return URL(string: baseURL + "query=macbook&display=100&start=\(start)&sort=\(sort)")!

        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return  ["X-Naver-Client-Id": "skLvqKWpYQN5oOWjEK9g", "X-Naver-Client-Secret": "o8KK6vOXf6"]
    }
    
}
