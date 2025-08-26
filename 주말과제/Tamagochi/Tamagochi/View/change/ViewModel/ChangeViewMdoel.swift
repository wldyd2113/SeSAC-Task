//
//  ChangeViewMdoel.swift
//  Tamagochi
//
//  Created by 차지용 on 8/26/25.
//

import Foundation
import RxCocoa
import RxSwift

final class ChangeViewMdoel:BaseViewModelProtocol {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let selectCell: ControlEvent<Tamagochi>
    }
    
    struct Output {
        let tamagochiList: BehaviorSubject<[Tamagochi]>
        let selectedTamagochi: PublishSubject<Tamagochi>
    }
    
    func transform(input: Input) -> Output {
        let name = UserSave.nickName
        var list: [Tamagochi] = []
        list.append(Tamagochi(name: name, image: "1-6"))
        list.append(Tamagochi(name: name, image: "2-6"))
        list.append(Tamagochi(name: name, image: "3-6"))
        
        for _ in 4...20 {
            list.append(Tamagochi(name: name, image: "noImage"))
        }
        
        let tamagochiList: BehaviorSubject<[Tamagochi]> = BehaviorSubject(value: list)
        let selectedTamagochi: PublishSubject<Tamagochi> = PublishSubject()
        input.selectCell.bind(to: selectedTamagochi).disposed(by: disposeBag)
        
        
        return Output(tamagochiList: tamagochiList, selectedTamagochi: selectedTamagochi)
    }
    
}
