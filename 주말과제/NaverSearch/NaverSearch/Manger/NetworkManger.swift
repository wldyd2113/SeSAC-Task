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
        func shopData(_ searchTitle: String, sort: String = NaverURL.sim.rawValue, start: Int, success: @escaping (ShopInfo) -> (), fail: @escaping (ShopError) -> () ) {
            print(#function)

            let url = "\(NaverURL.url.rawValue)v1/search/shop.json?query=\(searchTitle)&display=100&start=\(start)&sort=\(sort)"
            let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.naverID, "X-Naver-Client-Secret": APIKey.naverSecret]
            AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseDecodable(of:ShopInfo.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                    print(value)
                case .failure(let error):

    //                if let errorss = try JSONDecoder().decode(ShopError.self, from: response.data!) {
    //                }
                    if response.response?.statusCode == 400 {
                        print("잘못된 요청 오류",error)
                    }
                    else if response.response?.statusCode == 401 {
                        print("인증되지 않은 요청오류", error)
                    }
                    else if response.response?.statusCode == 404 {
                        print("자원 없음 오류",error)
                    }
                    else if response.response?.statusCode == 429 {
                        print("요청 횟수 초과 오류", error)
                    }
                    else if response.response?.statusCode == 500 {
                        print("서버 사용량 폭주!!", error)
                    }
                    else if response.response?.statusCode == 501 {
                        print("기능이 구현이 안되어있음", error)
                    }
                    else if response.response?.statusCode == 503 {
                        print("서버 상태 확인 요청", error)
                    }
                    
                    print("에러 발생", error)
                }

            }
        }
        
        func shopMacData(sort: String = NaverURL.sim.rawValue, start: Int, success: @escaping (ShopInfo) -> (), fail: @escaping () -> () ) {
            let url = "\(NaverURL.url.rawValue)v1/search/shop.json?query=macbook&display=100&start=\(start)&sort=\(sort)"
            let header: HTTPHeaders = ["X-Naver-Client-Id": "skLvqKWpYQN5oOWjEK9g", "X-Naver-Client-Secret": "o8KK6vOXf6"]
            AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseDecodable(of: ShopInfo.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                    print("MAC:", value)
                case .failure(let error):
                    if response.response?.statusCode == 400 {
                        print("잘못된 요청 오류",error)
                    }
                    else if response.response?.statusCode == 401 {
                        print("인증되지 않은 요청오류", error)
                    }
                    else if response.response?.statusCode == 404 {
                        print("자원 없음 오류",error)
                    }
                    else if response.response?.statusCode == 429 {
                        print("요청 횟수 초과 오류", error)
                    }
                    else if response.response?.statusCode == 500 {
                        print("서버 사용량 폭주!!", error)
                    }
                    else if response.response?.statusCode == 501 {
                        print("기능이 구현이 안되어있음", error)
                    }
                    else if response.response?.statusCode == 503 {
                        print("서버 상태 확인 요청", error)
                    }
                    fail()
                    print("에러 발생", error)
                }
            }
        }
        
        
    }
