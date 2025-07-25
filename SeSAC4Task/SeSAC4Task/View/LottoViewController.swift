//
//  LottoViewController.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    let pickerList: [Int] = Array(1...1811)
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
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.text = "회차"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let number1: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .yellow

        return label
    }()
    let number2: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .systemBlue

        return label
    }()
    let number3: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .systemBlue

        return label
    }()
    let number4: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .systemRed

        return label
    }()
    let number5: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .systemRed

        return label
    }()
    let number6: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .gray

        return label
    }()
    let plusView: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let number7: UILabel = {
        let label = LottLabel()
        label.backgroundColor = .gray
        return label
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
        getLottomData(numberLotto: updateLotto())
    }
    @objc func nvButtonTappend() {
        let vc = MovieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //로또 최신회차 계산
    func updateLotto() -> Int{
        let now = Date() //현재 시간 출력
        let calendar = Calendar.current //현재 날짜 출력

        var componets = DateComponents() //DateComponents로 날짜 변경
        componets.year = 2002
        componets.month = 12
        componets.day = 7
        let fristLotto = calendar.date(from: componets)

        componets = calendar.dateComponents([.day], from: fristLotto!, to: now) //총 일 계산
        let lotto = componets.day
        let reuslt = lotto! / 7 + 1
        return reuslt
        
    }
    
    func getLottomData(numberLotto: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(numberLotto)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.titleLabel.text = "\(value.drwNo)회 당첨 결과"
                self.number1.text = "\(value.drwtNo1)"
                self.number2.text = "\(value.drwtNo2)"
                self.number3.text = "\(value.drwtNo3)"
                self.number4.text = "\(value.drwtNo4)"
                self.number5.text = "\(value.drwtNo5)"
                self.number6.text = "\(value.drwtNo6)"
                self.number7.text = "\(value.bnusNo)"
                self.dateLabel.text = "\(value.drwNoDate)"
                print(value)
            case .failure(_):
                print("실패")
            }
            
        }
    }

}
//MARK: Picker Extension
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //피커 뷰의 열을 의미
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(pickerList[row])"
        getLottomData(numberLotto: Int(numberTextField.text!)!)
        print(getLottomData)
    }

}


//MARK: extension
extension LottoViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(numberTextField)
        view.addSubview(textLabel)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(number4)
        view.addSubview(number5)
        view.addSubview(number6)
        view.addSubview(plusView)
        view.addSubview(number7)

        view.addSubview(nvButton)
        numberTextField.inputView = picker
        picker.delegate = self
        
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

        nvButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-200)
            make.height.equalTo(44)
            make.width.equalTo(240)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(100)
            make.centerX.equalTo(view)
        }
        number1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(80)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(number1.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(number2.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        number4.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(number3.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        number5.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(number4.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        number6.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(number5.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        plusView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(number6.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        number7.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(plusView.snp.trailing).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        
    }
    
    
    
}
