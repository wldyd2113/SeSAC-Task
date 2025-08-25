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
    
    static func getLotto(query: String) -> Observable<Lotto> {
        
        return Observable<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"

            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                    
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print("error", error)
                }
                
            }
            return Disposables.create()
        }
    }
    
    static func getMovie(year: String) -> Observable<[DailyBoxOfficeList]> {
        return Observable<[DailyBoxOfficeList]>.create{ observer in
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e4585261643a6792f70ec61f206790a7&targetDt=\(year)"
            
            AF.request(url).responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value.boxOfficeResult.dailyBoxOfficeList)
                    observer.onCompleted()
                case .failure(let error):
                    print("error", error)
                }
            }
            return Disposables.create()
        }

    }

    
}
