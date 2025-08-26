//
//  NickNameViewModel.swift
//  Tamagochi
//
//  Created by 차지용 on 8/26/25.
//

import Foundation
import RxCocoa
import RxSwift

final class NickNameViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let nickNameText: ControlProperty<String>
        let saveBtuttonTap: ControlEvent<Void>
    }
    
    struct Output {
        let alertNickName: PublishRelay<Bool>
        let nextView: PublishRelay<Void>
    }
    
    func transform(input: Input) -> Output {
        let alertNickName = PublishRelay<Bool>()
        let nextView = PublishRelay<Void>()
        
        input.saveBtuttonTap
            .withLatestFrom(input.nickNameText)
            .bind(with: self) { owner, value in
                if value.count > 6 || value.count < 2 {
                    alertNickName.accept(true)
                }
                else {
                    UserSave.nickName = value
                    nextView.accept(())
                    print("저장")
                }
            }
            .disposed(by: disposeBag)
        return Output(alertNickName: alertNickName, nextView: nextView)
    }
    
}
