//
//  LottoViewController.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickerData: [Int] = Array(1...1811)
    let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "숫자"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.borderStyle = .line
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-05-30 추첨"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let tabelView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        return tableView
    }()
    
    let nvButton: UIButton = {
        let button = UIButton()
        button.setTitle("Movies", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(nvButtonTappend), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLayout()
        
    }
    @objc func nvButtonTappend() {
        let vc = MovieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    //MARK: Table메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LottoTableViewCell.identifier, for: indexPath) as! LottoTableViewCell
        var round = pickerData[indexPath.row]
//        cell.configureCell(round: round)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //MARK: Picker 메서드
    //피커 뷰의 열을 의미
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var round = pickerData[row]
        numberTextField.text = "\(round)"
        tabelView.reloadData()
    }
    
}
//MARK: extension
extension LottoViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(numberTextField)
        view.addSubview(textLabel)
        view.addSubview(dateLabel)
        view.addSubview(tabelView)
        view.addSubview(nvButton)
        numberTextField.inputView = picker
        tabelView.delegate = self
        tabelView.dataSource = self
        picker.delegate = self
        
        tabelView.register(LottoTableViewCell.self, forCellReuseIdentifier: LottoTableViewCell.identifier)
    }
    
    func configureLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-15)
        }
        tabelView.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(60)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(nvButton.snp.top).offset(-200)
        }
        nvButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-200)
            make.height.equalTo(44)
            make.width.equalTo(240)
        }
        
    }
    
    
    
}
