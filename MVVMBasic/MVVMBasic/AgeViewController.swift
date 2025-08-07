//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum BoxOfficeError: Error {
    case outOfrange
    case isInt
    case isEmptySpace
}

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        setButton(resultButton)
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        guard let textAge = textField.text else { return }
        do {
            let _ = try userText(text: textAge)
            label.text = textAge
        }
        catch BoxOfficeError.outOfrange {
            label.text = "범위에 해당이 안됩니다"
        }
        catch BoxOfficeError.isInt {
            label.text = "숫자를 입력해주세요"

        }
        catch BoxOfficeError.isEmptySpace {
            label.text = "1~100 사이의 나이를 입력해주세요"
        }
        catch {
            label.text = "error"
        }
    }
    
    func userText(text: String) throws -> Bool {
        guard Int(text) ?? 0 >= 1 && Int(text) ?? 0 <= 100 else {
            print("범위 초과")
            throw BoxOfficeError.outOfrange
        }
        guard !(text.isEmpty) else {
            print("빈 문자")
            throw BoxOfficeError.isEmptySpace
        }

        guard Int(text) != nil else {
            print("숫자가 아닙니다")
            throw BoxOfficeError.isInt
        }
        
        return true
    }
}
