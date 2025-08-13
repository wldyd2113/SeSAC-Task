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
        
        func shopCallRequest<T: Codable>(api: NetworkRouter, type: T.Type,success: @escaping (T) -> (), fail: @escaping (ShopError) -> () ) {
            print(#function)

            AF.request(api.endpoint, method: api.method, headers: api.headers).validate(statusCode: 200..<500).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                    print(value)
                case .failure(let error):

    //                if let errorss = try JSONDecoder().decode(ShopError.self, from: response.data!) {
    //                }
                    //enum으로 관리
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
    }
