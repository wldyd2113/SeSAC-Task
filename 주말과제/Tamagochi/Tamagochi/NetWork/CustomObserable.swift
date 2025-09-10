//
//  CustomObserable.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import Foundation
import RxSwift
import Alamofire

final class CustomObserable {
    
    static func getLotto(query: String) -> Observable<Result<Lotto, AFError>> {
        
        return Observable<Result<Lotto,AFError>>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"

            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                    print("error", error)
                }
                
            }
            return Disposables.create()
        }
    }
    
    static func getMovie(year: String) -> Observable<Result<[DailyBoxOfficeList], AFError>> {
        return Observable<Result<[DailyBoxOfficeList], AFError>>.create{ observer in
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e4585261643a6792f70ec61f206790a7&targetDt=\(year)"
            
            AF.request(url).responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value.boxOfficeResult.dailyBoxOfficeList))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                    print("error", error)
                }
            }
            return Disposables.create()
        }

    }

    
}
