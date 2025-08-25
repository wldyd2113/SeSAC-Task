//
//  LottoViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class LottoViewController: UIViewController {
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    private let resultLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    let lottoList: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    private func bind() {
        button.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty)
            .flatMap { text in
                CustomObserable.getLotto(query: text)
            }
            .subscribe(with: self) { owner, lotto in
                owner.resultLabel.text = "\(lotto.drwtNo1), \(lotto.drwtNo2), \(lotto.drwtNo3), \(lotto.drwtNo4),  \(lotto.drwtNo5),  \(lotto.drwtNo6), \(lotto.bnusNo),"
                
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owenr in
                print("onDisposed")
            }
            .disposed(by: disposeBag)

    }

}
extension LottoViewController: DesginProtocol {
    func configureHirarchy() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(resultLabel)
    }
    
    func configureUI() {
        view.backgroundColor = .background
        textField.backgroundColor = .text
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.setTitleColor(.black, for: .normal)
        resultLabel.text = "dsadsadsadsadsa"
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(textField.snp.trailing).offset(8)
            make.width.equalTo(100)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaInsets).inset(8)
        }
    }
    
    
}
