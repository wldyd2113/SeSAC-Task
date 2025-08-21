//
//  SimpleValidationViewController.swift
//  RxMVVM
//
//  Created by 차지용 on 8/21/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ValidationViewModel()
    var usernameOutlet = UITextField()
    var usernameValidOutlet = UILabel()
    
    var passwordOutlet = UITextField()
    var passwordValidOutlet = UILabel()
    
    var doSomethingOutlet = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        configureLayout()
        view.backgroundColor = .white
        bind()
        

    }
    
    func bind() {
        let input = ValidationViewModel.Input(usernameOutlet: usernameOutlet.rx.text.orEmpty, passwordOutlet: passwordOutlet.rx.text.orEmpty, doSomethingTap: doSomethingOutlet.rx.tap)
        let output = viewModel.transfrom(input: input)
        
        output.usernameValidOutlet
            .bind(to: usernameValidOutlet.rx.text)
            .disposed(by: disposeBag)
        output.passwordValidOutlet
            .bind(to: passwordValidOutlet.rx.text)
            .disposed(by: disposeBag)
        
        output.everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.usernameValidBool
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.usernameValidBool
            .map { $0 }
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        output.passwordValidBool
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func configure() {
        view.addSubview(usernameOutlet)
        view.addSubview(usernameValidOutlet)
        view.addSubview(passwordOutlet)
        view.addSubview(passwordValidOutlet)
        view.addSubview(doSomethingOutlet)
    }
    
    func configureUI() {
        usernameOutlet.textColor = .black
        usernameOutlet.backgroundColor = .gray
        
        passwordOutlet.textColor = .black
        passwordOutlet.backgroundColor = .gray
        
        doSomethingOutlet.setTitle("Do something", for: .normal)
        doSomethingOutlet.setTitleColor(.black, for: .normal)
        doSomethingOutlet.backgroundColor = .green
    }
    
    func configureLayout() {
        usernameOutlet.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        usernameValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameOutlet.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        passwordOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameValidOutlet.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }

        passwordValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        doSomethingOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordValidOutlet.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }


    }
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
