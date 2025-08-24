//
//  TamagochiViewModel.swift
//  Tamagochi
//
//  Created by 차지용 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamagochiViewModel {
    
    let disposeBag = DisposeBag()
    var snederImage: String  {
        get {
            UserDefaults.standard.string(forKey: UserTamagochi.selectedTamagochi.rawValue) ?? "1" 
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserTamagochi.selectedTamagochi.rawValue)
        }
    }
    
    struct Input {
        let riceText: ControlProperty<String>
        let waterText: ControlProperty<String>
        let riceButtonTap: ControlEvent<Void>
        let waaterBttonTap: ControlEvent<Void>
        
    }
    
    struct Output {
        let riceCount: BehaviorSubject<Int>
        let waterCount: BehaviorSubject<Int>
        let level: BehaviorSubject<Int>
        let result:  Observable<String>
        let showRiceAlert: Observable<Void>
        let showWaterAlert: Observable<Void>
        let tamagochiImage: Observable<String>

    }
    

    func transform(input: Input) -> Output {
        
        let savedRice = UserDefaults.standard.integer(forKey: UserTamagochi.rice.rawValue)
        let savedWater = UserDefaults.standard.integer(forKey: UserTamagochi.water.rawValue)
        let savedLevel = UserDefaults.standard.integer(forKey: UserTamagochi.level.rawValue)
        
        let riceCount = BehaviorSubject(value: savedRice)
        let waterCount = BehaviorSubject(value: savedWater)
        let level = BehaviorSubject(value: savedLevel == 0 ? 1 : savedLevel)
        
        let showRiceAlert = PublishSubject<Void>()
        let showWaterAlert = PublishSubject<Void>()

        
        input.riceButtonTap
            .withLatestFrom(Observable.combineLatest(input.riceText, riceCount))
            .bind { text, currentRice in
                let amount = text.isEmpty ? 0 : Int(text) ?? 0
                if amount > 99 || amount < 0 {
                    showRiceAlert.onNext(())
                } else {
                    let plusRiceCount = currentRice + amount
                    riceCount.onNext(plusRiceCount)
                    UserDefaults.standard.set(plusRiceCount, forKey: UserTamagochi.rice.rawValue)
                }
            }
            .disposed(by: disposeBag)

        input.waaterBttonTap
            .withLatestFrom(Observable.combineLatest(input.waterText, waterCount))
            .bind { text, currentWater in
                let amount = text.isEmpty ? 0 : Int(text) ?? 0
                if amount > 99 || amount < 0 {
                    showWaterAlert.onNext(())
                } else {
                    let plusWaterCount = currentWater + amount
                    waterCount.onNext(plusWaterCount)
                    UserDefaults.standard.set(plusWaterCount, forKey: UserTamagochi.water.rawValue)
                }
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(riceCount, waterCount)
                .map { rice, water in
                    let calculatLevel = (rice / 5) + (water / 2)
                    return min(max(calculatLevel + 1, 1), 10) 
                }
                .bind { value in
                    level.onNext(value)
                    UserDefaults.standard.set(value, forKey: UserTamagochi.level.rawValue)
                }
                .disposed(by: disposeBag)
        
        let result = Observable.combineLatest(level, riceCount, waterCount)
            .map { lv, rice, water in
                return "LV\(lv) 밥알 \(rice)개 물방울 \(water)개"
            }
        let tamagochiImage = level.map { lv -> String in
            return "\(self.snederImage)-\(min(lv, 9))"
        }
        
        return Output(riceCount: riceCount, waterCount: waterCount, level: level, result: result, showRiceAlert: showRiceAlert, showWaterAlert: showWaterAlert, tamagochiImage: tamagochiImage)
    }
    
}
