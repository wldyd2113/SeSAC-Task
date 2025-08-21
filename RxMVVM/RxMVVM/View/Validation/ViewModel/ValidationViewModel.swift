//
//  ValidationViewModel.swift
//  RxMVVM
//
//  Created by 차지용 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ValidationViewModel {
    let disposeBag = DisposeBag()

    
    struct Input {
        let usernameOutlet: ControlProperty<String>
        let passwordOutlet: ControlProperty<String>
        let doSomethingTap: ControlEvent<Void>
    }
    
    struct Output {
        let usernameValidOutlet: BehaviorSubject<String>
        let passwordValidOutlet: BehaviorSubject<String>
        let usernameValidBool: Observable<Bool>
        let passwordValidBool: Observable<Bool>
        let everythingValid: Observable<Bool>
    }
    
    func transfrom(input: Input) -> Output {
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
        
        let usernameValidOutlet = BehaviorSubject(value: "Username has to be at least \(minimalUsernameLength) characters")
        let passwordValidOutlet = BehaviorSubject(value: "Password has to be at least \(minimalPasswordLength) characters")
        let usernameValid = input.usernameOutlet
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)

        let passwordValid = input.passwordOutlet
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        input.doSomethingTap.bind(with: self) { owner, _ in
            
        }
        .disposed(by: disposeBag)
        

        return Output(usernameValidOutlet: usernameValidOutlet, passwordValidOutlet: passwordValidOutlet, usernameValidBool: usernameValid, passwordValidBool: passwordValid, everythingValid: everythingValid)
    }
}
