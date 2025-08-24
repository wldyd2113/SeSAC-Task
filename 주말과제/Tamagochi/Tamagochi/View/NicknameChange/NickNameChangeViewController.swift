//
//  NickNameChangeViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NickNameChangeViewController: UIViewController {
    
    let nickNameTextField = UITextField()
    let lineView = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()

    }
    
    @objc func saveNickname() {
        if nickNameTextField.text!.count > 6 || nickNameTextField.text!.count < 2{
            alertNickName()
        }
        else {
            UserDefaults.standard.set(nickNameTextField.text ?? "", forKey: UserTamagochi.nickName.rawValue)
            let vc = TamagochiViewController()
            vc.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(vc, animated: true)
            print("저장")
        }
    }
    
    func alertNickName() {
        let alert = UIAlertController(title: "닉네임 글자제한", message: "닉네임은 2글자 이상 6글자 이하로 입력해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }

}
extension NickNameChangeViewController: DesginProtocol {
    func configureHirarchy() {
        view.addSubview(nickNameTextField)
        view.addSubview(lineView)
    }
    
    func configureUI() {
        view.backgroundColor = .background
        navigationItem.title = "닉네임 변경"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text.cgColor]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNickname))
        
        nickNameTextField.placeholder = "닉네임을 입력하세요"
        lineView.backgroundColor = .text

    }
    
    
    func configureLayout() {
        nickNameTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(nickNameTextField)
            make.height.equalTo(1)
        }
    }
    
    
}
