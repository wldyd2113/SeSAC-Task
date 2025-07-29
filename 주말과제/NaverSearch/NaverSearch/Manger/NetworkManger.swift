//
//  NetworkManger.swift
//  NaverSearch
//
//  Created by 차지용 on 7/29/25.
//

import Foundation
import Alamofire

class NetworkManger {
    static let shared = NetworkManger()
    
    //검색 데이터
    func shopData(_ searchTitle: String, sort: String = "sim", start: Int, success: @escaping (ShopInfo) -> (), fail: @escaping () -> () ) {
        print(#function)

        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchTitle)&display=30&start=\(start)&sort=\(sort)"
        let header: HTTPHeaders = ["X-Naver-Client-Id": "skLvqKWpYQN5oOWjEK9g", "X-Naver-Client-Secret": "o8KK6vOXf6"]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of:ShopInfo.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
                print(value)
            case .failure(let error):
                fail()
                
                print("에러 발생", error)
            }

        }
    }
    
    func shopMacData(sort: String = "sim", start: Int, success: @escaping (ShopInfo) -> (), fail: @escaping () -> () ) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=macbook&display=30&start=\(start)&sort=\(sort)"
        let header: HTTPHeaders = ["X-Naver-Client-Id": "skLvqKWpYQN5oOWjEK9g", "X-Naver-Client-Secret": "o8KK6vOXf6"]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of: ShopInfo.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
                print("MAC:", value)
            case .failure(let error):
                fail()
                print("에러 발생", error)
            }
        }
    }
}
