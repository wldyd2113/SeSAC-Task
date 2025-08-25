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
                case .failure(let Error):
                    print("error", Error)
                }
                
            }
            return Disposables.create()
        }
    }
    
}
