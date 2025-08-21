//
//  NumbersViewModel.swift
//  RxMVVM
//
//  Created by 차지용 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NumbersViewModel {
    let diposeBag = DisposeBag()
    struct Input {
        let number1Text: ControlProperty<String>
        let number2Text: ControlProperty<String>
        let number3Text: ControlProperty<String>
    }
    
    struct Output {
        let resultText: BehaviorSubject<String>
    }
    
    func transform(input: Input) -> Output {
        let resultText = BehaviorSubject(value: "")
        Observable.combineLatest(input.number1Text, input.number2Text, input.number3Text) {
            text1, text2, text3 -> Int in
            return (Int(text1) ?? 0) +  (Int(text2) ?? 0) +  (Int(text3) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultText)
        .disposed(by: diposeBag)
        return Output(resultText: resultText)
    }
}
