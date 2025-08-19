//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by 차지용 on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NumbersViewController: UIViewController {
    
    let diposeBag = DisposeBag()
    
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    
    let plusLabel: UILabel = {
       let label = UILabel()
        label.text = "+"
        label.textColor = .black
        return label
    }()
    
    let resultLabel = UILabel()
    
    let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        configureUI()
        configureLayout()
        
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) {
            text1, text2, text3 -> Int in
            return (Int(text1) ?? 0) +  (Int(text2) ?? 0) +  (Int(text3) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: diposeBag)

    }
    
    
    func configure() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(plusLabel)
        view.addSubview(resultLabel)


    }
    func configureUI() {
        number1.placeholder = "1"
        number1.backgroundColor = .blue

        number2.placeholder = "2"
        number2.backgroundColor = .blue

        number3.placeholder = "3"
        number3.backgroundColor = .blue
        
        resultLabel.textColor = .black
        resultLabel.text = "-1"
        resultLabel.backgroundColor = .blue


    }
    func configureLayout() {
        number1.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.centerY.equalToSuperview()
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(150)
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(150)
        }
        plusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(number3.snp.leading).offset(-16)
            make.top.equalTo(number2.snp.bottom).offset(8)

        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(150)
        }

    }


}
