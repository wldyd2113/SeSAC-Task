//
//  BoxOfficeViewModel.swift
//  Tamagochi
//
//  Created by 차지용 on 8/26/25.
//

import Foundation
import RxCocoa
import RxSwift
class BoxOfficeViewModel: BaseViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searText: ControlProperty<String>
        let searTap: ControlEvent<Void>
    }
    
    struct Output {
        let resultText: BehaviorRelay<[DailyBoxOfficeList]>
        let showAlert: PublishRelay<Bool>
        let tostMessage: PublishRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let resultText: BehaviorRelay<[DailyBoxOfficeList]> = BehaviorRelay(value: [DailyBoxOfficeList(rank: "1", movieNm: "if Only")])
        let showAlert: PublishRelay<Bool> = PublishRelay()
        let tostMessage: PublishRelay<Bool> = PublishRelay()
        input.searTap
            .withLatestFrom(input.searText)
//            .retry(100)
            .flatMap { text in
                CustomObserable.getMovie(year: text)
                    .catch { text in
                        return Observable.never()
                    }
            }
            .subscribe(with: self) { owner, boxOffice in
                
                switch boxOffice {
                case .success(let value):
                    resultText.accept(value)
                    print(value)
                case .failure(let error):
                    switch error {
                    case .sessionTaskFailed(error: _):
                        print(error)
                        showAlert.accept(true)
                    case .responseSerializationFailed(reason: _):
                        tostMessage.accept(true)
                    default: break
                    }
                    print("error", error)
                    
                }
                
            } onError: { owner, error in
                
            } onCompleted: { owner in
                
            } onDisposed: { owner in
                
            }
            .disposed(by: disposeBag)
        
        return Output(resultText: resultText, showAlert: showAlert, tostMessage: tostMessage)
    }
    
    
}
