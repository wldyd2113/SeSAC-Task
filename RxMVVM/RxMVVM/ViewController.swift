//
//  ViewController.swift
//  RxMVVM
//
//  Created by 차지용 on 8/21/25.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        withLatestFrom()

    }
    func combinLatest() {
        let person = Observable.from(["철수", "영희", "준석", "정인"])
        let pet = Observable.from(["cat", "dog", "bird", "pig"])
        
        Observable.combineLatest(person, pet) { person, pet in
            return (person, pet)
        }.subscribe { event in
            print(event)
        } .disposed(by: disposeBag)
    }
    func zip() {
        let person = Observable.from(["철수", "영희", "준석", "정인"])
        let pet = Observable.from(["cat", "dog", "bird", "pig"])
        
        Observable.zip(person, pet) { person, pet in
            return (person, pet)
        }.subscribe { event in
            print(event)
        } .disposed(by: disposeBag)
    }
    
    func withLatestFrom() {
        let inputNum = PublishSubject<Int>()
        let inputStr = PublishSubject<String>()
        
        inputNum
            .withLatestFrom(inputStr) { "\($0)\($1)"}
            .subscribe(onNext: { print($0)} )
            .disposed(by: disposeBag)
        
        inputNum.onNext(1)
        inputStr.onNext("일")

        // 2일
        inputNum.onNext(2)
        inputStr.onNext("이")
        inputStr.onNext("삼")
        inputStr.onNext("사")

        // 3사
        inputNum.onNext(3)
        // 4사
        inputNum.onNext(4)
        // 5사
        inputNum.onNext(5)
    }



}

