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
                    switch response.response?.statusCode {
                    case ErrorCode.case400.rawValue:
                        print("잘못된 요청 오류",error)
                    case ErrorCode.case401.rawValue:
                        print("인증되지 않은 요청오류", error)
                    case ErrorCode.case404.rawValue:
                        print("자원 없음 오류",error)
                    case ErrorCode.case429.rawValue:
                        print("요청 횟수 초과 오류", error)
                    case ErrorCode.case500.rawValue:
                        print("서버 사용량 폭주!!", error)
                    case ErrorCode.case501.rawValue:
                        print("기능이 구현이 안되어있음", error)
                    case ErrorCode.case503.rawValue:
                        print("서버 상태 확인 요청", error)
                    default :
                        print("에러 발생", error)
                    }
                }

            }
        }
    }
