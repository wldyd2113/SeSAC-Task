//
//  UpDownViewController.swift
//  UpDoungame
//
//  Created by 차지용 on 7/22/25.
//

import UIKit
import SnapKit

class UpDownViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UP DOWN"
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "GAME"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "emotion1")
        return image
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "숫자를 입력해주세요"
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        textField.borderStyle = .none

        return textField
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(mainImage)
        view.addSubview(numberTextField)
        view.addSubview(startButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(30)
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    
    
    @objc func startButtonTapped() {
        guard let number = Int(numberTextField.text ?? "0") else { return }
        print(number)
        let vc = StartGameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
