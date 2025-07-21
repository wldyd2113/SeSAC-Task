//
//  LoginViewController.swift
//  SnapKitPr
//
//  Created by 차지용 on 7/21/25.
//

import UIKit
import SnapKit
class LoginViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "JackFlex"
        label.textColor = .red
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "이메일 주소 또는 전화번호"
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textColor = .white
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textColor = .white
        return textField
    }()
    
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textColor = .white
        return textField
    }()
    
    let locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "위치"
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textColor = .white
        return textField
    }()
    
    let codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "추천 코드"
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textColor = .white
        return textField
    }()
    let joinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("추가 정보 입력", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    let switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = true
        switchButton.onTintColor = .red
        return switchButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nickNameTextField)
        view.addSubview(locationTextField)
        view.addSubview(codeTextField)
        view.addSubview(joinButton)
        view.addSubview(infoButton)
        view.addSubview(switchButton)
        
        viewLayout()
    }
    func viewLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(45)
            make.width.equalTo(110)
            make.height.equalTo(40)

        }
        
        switchButton.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).offset(20)
            make.leading.equalTo(infoButton.snp.trailing).offset(150)
            make.width.equalTo(110)
            make.height.equalTo(40)

        }
        
    }
    
    
}
