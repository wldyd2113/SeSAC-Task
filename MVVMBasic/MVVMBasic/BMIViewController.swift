//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum BMIError: Error {
    case heightOutOfRange
    case weightOutOfRange
}

class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
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
        guard let height = heightTextField.text else { return }
        guard let weight = weightTextField.text else { return }
        
        do {
            let _ = try bmiError(heightText: height, weightText: weight)
            resultLabel.text = height + "," + weight
        }
        catch {
            switch error {
            case .heightOutOfRange:
                heightAlert(height)
            case .weightOutOfRange:
                weightAlert(weight)
            }
        }
        
    }
    func bmiError(heightText: String, weightText: String) throws(BMIError) -> Bool {
        guard Int(heightText) ?? 0 <= 200 else {
            print("키 초과")
            throw .heightOutOfRange
        }
        guard Int(weightText) ?? 0 <= 210 else {
            print("몸무게 초과")
            throw .weightOutOfRange
        }
        return true
    }
    func heightAlert(_ message: String) {
        //1. 밑바탕
        let alert = UIAlertController(title: "키 범위 초과", message: "\(message)은 키 201범위과 초과했습니다 다시 입력해주새요", preferredStyle: .alert)
        //2.
        let ok = UIAlertAction(title: "확인", style: .default)
        //3. addAction 순서대로 붙음
        alert.addAction(ok)
        
        
        //4. 화면에 띄워주는 작업
        present(alert, animated: true)
    }
    
    func weightAlert(_ message: String) {
        //1. 밑바탕
        let alert = UIAlertController(title: "몸무게 범위 초과", message: "\(message)은 몸무게 211 범위과 초과했습니다 다시 입력해주새요", preferredStyle: .alert)
        //2.
        let ok = UIAlertAction(title: "확인", style: .default)
        //3. addAction 순서대로 붙음
        alert.addAction(ok)
        
        
        //4. 화면에 띄워주는 작업
        present(alert, animated: true)
    }
}
