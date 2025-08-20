//
//  SimpleValidationViewController.swift
//  RxSampleProject
//
//  Created by 차지용 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {
    let disposeBag = DisposeBag()
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
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
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
        usernameOutlet.text = "Username"
        usernameOutlet.textColor = .black
        usernameOutlet.backgroundColor = .gray
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
