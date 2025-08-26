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
    
    let resutlText: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()
    private let viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    
    private func bind() {
        let input = LottoViewModel.Input(lottoTap: button.rx.tap, lottoText: textField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.resutlText.bind(with: self) { owner, value in
            owner.resultLabel.text = "\([value])"
        }
        .disposed(by: disposeBag)
        
        output.showAlert.bind(with: self) { owner, value in
            if value {
                owner.alert()
            }
        }
        .disposed(by: disposeBag)
        
        output.tostMessage.bind(with: self) { owner, value in
            if value {
                owner.tostMessage()
            }
        }
        .disposed(by: disposeBag)
        
    }
    
    func tostMessage() {
        let toastLabel = UILabel(frame: CGRect(x: 20, y: self.view.frame.size.height-100, width: view.frame.size.width-2*20, height: 50)) 
        toastLabel.backgroundColor = UIColor.text.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = .center
        toastLabel.text = "검색을 잘못 하셨습니다 숫자를 입력해주세요!"
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.masksToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut) {
            toastLabel.alpha = 0
        } completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "통신문제발생!!", message: "데이터를 확인해주세요,와이파이를 연결해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
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
        resultLabel.numberOfLines = 0
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
