//
//  ProfileViewController.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import UIKit
import SnapKit

enum NickNameError: Error {
    case outOfNicknameError
    case particularError
    case emptyError
    case isStringError
    
}

class ProfileViewController: UIViewController {
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.image = UIImage(systemName: "person.circle")
        return image
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요:)"
        return textField
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "사용할 수 있는 닉네임이에요"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let ebutton: UIButton = {
        let button = UIButton()
        button.setTitle("E", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.width / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    let sbutton: UIButton = {
        let button = UIButton()
        button.setTitle("S", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.width / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    let tbutton: UIButton = {
        let button = UIButton()
        button.setTitle("T", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    let jbutton: UIButton = {
        let button = UIButton()
        button.setTitle("J", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    let ibutton: UIButton = {
        let button = UIButton()
        button.setTitle("I", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    let nbutton: UIButton = {
        let button = UIButton()
        button.setTitle("N", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    let fbutton: UIButton = {
        let button = UIButton()
        button.setTitle("F", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    let pbutton: UIButton = {
        let button = UIButton()
        button.setTitle("P", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let eiStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    let snStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    let tfStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    let jpStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureHierarchy()
        configureLayout()
    }
    
    
    
    //테두리 없애기
    func textFieldUI(_ textField: UITextField) {
        textField.borderStyle = .line
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 1)
        border.backgroundColor = UIColor.gray.cgColor
        textField.layer.addSublayer(border)
    }
    
    func configure() {
        navigationItem.title = "PROFILE SETTING"
        view.backgroundColor = .white
        
    }
    
    func configureHierarchy() {
        view.addSubview(profileImage)
        view.addSubview(nicknameTextField)
        view.addSubview(statusLabel)
        view.addSubview(mbtiLabel)
        view.addSubview(eiStackView)
        view.addSubview(snStackView)
        view.addSubview(tfStackView)
        view.addSubview(jpStackView)
        view.addSubview(completeButton)
        
        eiStackView.addArrangedSubview(ebutton)
        eiStackView.addArrangedSubview(ibutton)
        snStackView.addArrangedSubview(sbutton)
        snStackView.addArrangedSubview(nbutton)
        tfStackView.addArrangedSubview(tbutton)
        tfStackView.addArrangedSubview(fbutton)
        jpStackView.addArrangedSubview(jbutton)
        jpStackView.addArrangedSubview(pbutton)
    }
    
    func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(150)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        eiStackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(24)
            make.leading.equalTo(mbtiLabel.snp.trailing).offset(80)
        }
        snStackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(24)
            make.leading.equalTo(eiStackView.snp.trailing).offset(8)

        }
        tfStackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(24)
            make.leading.equalTo(snStackView.snp.trailing).offset(8)
        }
        
        jpStackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(24)
            make.leading.equalTo(tfStackView.snp.trailing).offset(8)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
    }
    
    
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let nicknamke = nicknameTextField.text else { return }
        
        do {
            let _ = try nickError(nicknamke)
            statusLabel.text = "사용할 수 있는 닉네임 입니다"
            statusLabel.textColor = ._186_FF_2
        }
        catch {
            
        }
        
        if nicknamke.count >= 2 && nicknamke.count < 10 {
            statusLabel.text = "2글자 이상 10글자 미만으로 입력해주세요"
        }
        else if  nicknamke.contains("@") || nicknamke.contains("#") || nicknamke.contains("$") || nicknamke.contains("%") {
            statusLabel.text = "@, #, $, % 4개의 특수문자 및 숫자 사용 불가합니다"
        }
    }
    
    func nickError(_ text: String) throws -> Bool {
        guard text.isEmpty else { throw NickNameError.emptyError}
        guard text.count >= 2 && text.count < 10 else { throw NickNameError.outOfNicknameError }
        guard text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") else { throw NickNameError.particularError}
        guard text.rangeOfCharacter(from: .decimalDigits) != nil else { throw NickNameError.isStringError }
        return true
    }
}
