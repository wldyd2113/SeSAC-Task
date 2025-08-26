//
//  LottoViewModel.swift
//  Tamagochi
//
//  Created by 차지용 on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel: BaseViewModelProtocol {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let lottoTap: ControlEvent<Void>
        let lottoText: ControlProperty<String>
    }
    
    struct Output {
        let resutlText: BehaviorRelay<[Lotto]>
        let showAlert: PublishRelay<Bool>
        let tostMessage: PublishRelay<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        var resutlText = BehaviorRelay(value: [Lotto(drwtNo1: 1, drwtNo2: 2, drwtNo3: 3, drwtNo4: 4, drwtNo5: 5, drwtNo6: 6, bnusNo: 8)])
        let showAlert = PublishRelay<Bool>()
        let tostMessage = PublishRelay<Bool>()
        
        input.lottoTap
            .withLatestFrom(input.lottoText)
            .flatMap { text in
                CustomObserable.getLotto(query: text)
                    .catch { text in
                        return Observable.never()
                    }
            }
            .subscribe(with: self) { owner, lotto in
                switch lotto {
                case .success(let value):
                    resutlText.accept([value])
                case .failure(let error):
                    switch error {
                    case .sessionTaskFailed(error: _): //URL요청실패
                        print(error)
                        showAlert.accept(true)
                        
                    case .responseSerializationFailed(reason: _):
                        tostMessage.accept(true)
                    default: break
                        
                    }
                }
                
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owenr in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(resutlText: resutlText, showAlert: showAlert, tostMessage: tostMessage)
        
    }
}


