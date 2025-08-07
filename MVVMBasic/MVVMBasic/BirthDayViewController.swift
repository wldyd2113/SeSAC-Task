//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit
enum BirthDayError: Error {
    case yearOutOfRange
    case monthOutOfRange
    case dayOutOfRange
}
class BirthDayViewController: UIViewController {
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
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
        setLabel(label: resultLabel)
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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
        guard let year = yearTextField.text,
              let month = monthTextField.text,
              let day = dayTextField.text else { return }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        let today = Calendar.current.startOfDay(for: date)

        
        guard let year = yearTextField.text else { return }
        guard let month = monthTextField.text else { return }
        guard let day = dayTextField.text else { return }
        do {
            let inputDate = try userText(year, month, day)
            let birthDay = Calendar.current.startOfDay(for: inputDate)
            let components = Calendar.current.dateComponents([.day], from: birthDay, to: today)
            let dDay = components.day ?? 0

            resultLabel.text = "\(dateString)기준으로 +\(dDay)일째 입니다"
        }
        catch BirthDayError.yearOutOfRange {
            resultLabel.text = "년도는 2025년 까지 입력할수 있습니다"
        }
        catch BirthDayError.monthOutOfRange {
            resultLabel.text = "월은 12월까지 있습니다"
        }
        catch BirthDayError.dayOutOfRange {
            resultLabel.text = "일은 31일까지 있습니다"
        }
        catch {
            
        }

    }
    
    func userText(_ yearText: String, _ monthText: String, _ dayText: String) throws -> Date {
        guard let year = Int(yearText), year <= 2025 else { throw BirthDayError.yearOutOfRange }
        guard let month = Int(monthText),  month <= 12 else { throw BirthDayError.monthOutOfRange }
        guard let day = Int(dayText), day <= 31 else { throw BirthDayError.dayOutOfRange }
        
        let calendar = Calendar.current
        var inputDate = DateComponents()
        inputDate.year = year
        inputDate.month = month
        inputDate.day = day
        guard let newDate = calendar.date(from: inputDate) else { return Date() }
        
        return newDate
    }
}
