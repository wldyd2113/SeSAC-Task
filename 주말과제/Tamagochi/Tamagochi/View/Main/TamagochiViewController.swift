//
//  TamagochiViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TamagochiViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = TamagochiViewModel()
    
    private let statusList = ["좋은 하루에요!", "밥 주세요!!!", "조금 더 성장 시켜주세요!", "집중하세요!", "이 주신 간식 최고였어요!", "RxSwift에 대해 알아봐요!"]
    private let speechBubbleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "말풍선")
        return image
    }()
    private let tamagochiImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "2-1")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 70
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.text.cgColor
        image.layer.masksToBounds = true
        return image
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "방실방실 다마고치"
        label.textColor = .text
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.text.cgColor
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "LV1 밥알 0개 물방울 0개"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .text
        label.textAlignment = .center
        return label
    }()
    
    private let riceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "밥주세용"
        textField.backgroundColor = .background
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let waterTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "물주세용"
        textField.keyboardType = .numberPad
        textField.backgroundColor = .background
        return textField
    }()
    
    private let riceButton = {
        let button = UIButton()
        button.backgroundColor = .background
        button.setImage(UIImage(systemName: "drop.circle.fill"), for: .normal)
        button.setTitle("밥먹기", for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.text.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    private let waterButton = {
        let button = UIButton()
        button.backgroundColor = .background
        button.setImage(UIImage(systemName: "leaf.fill"), for: .normal)
        button.setTitle("물먹기", for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.text.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusLabel.text = statusList.randomElement()
    }
    
    private func bind() {
        let input = TamagochiViewModel.Input(
            riceText: riceTextField.rx.text.orEmpty,
            waterText: waterTextField.rx.text.orEmpty,
            riceButtonTap: riceButton.rx.tap,
            waaterBttonTap: waterButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
    
        output.result.bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tamagochiImage.bind(with: self) { owner, value in
            owner.tamagochiImage.image = UIImage(named: value)
        }
        .disposed(by: disposeBag)

        output.showRiceAlert.bind(with: self) { owner, _ in
            owner.alertRiceView()
        }
        .disposed(by: disposeBag)
        
        output.showWaterAlert.bind(with: self) { owner, _ in
            owner.alertWaterView()
        }
        .disposed(by: disposeBag)
        
        riceButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.riceTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        waterButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.waterTextField.text = ""
            }
            .disposed(by: disposeBag)

        
    }
    
    @objc func settingTapped() {
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alertRiceView() {
        let alert = UIAlertController(title: "밥양", message: "밥양은 99까지 입니다", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func alertWaterView() {
        let alert = UIAlertController(title: "물양", message: "물양은 49까지 입니다", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    
    
}

extension TamagochiViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension TamagochiViewController: DesginProtocol {
    func configureHirarchy() {
        view.addSubview(speechBubbleImage)
        speechBubbleImage.addSubview(statusLabel)
        view.addSubview(tamagochiImage)
        view.addSubview(nameLabel)
        view.addSubview(resultLabel)
        view.addSubview(riceTextField)
        view.addSubview(waterTextField)
        view.addSubview(riceButton)
        view.addSubview(waterButton)
        riceTextField.delegate = self
        waterTextField.delegate = self

    }
    
    func configureUI() {
        view.backgroundColor = .background
        navigationItem.title = "대장님의 다마고치"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingTapped))
    }
    
    func configureLayout() {
        speechBubbleImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(view)
            make.width.height.equalTo(130)
        }
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(speechBubbleImage)
            make.centerY.equalTo(speechBubbleImage)
        }
        tamagochiImage.snp.makeConstraints { make in
            make.top.equalTo(speechBubbleImage.snp.bottom).offset(5)
            make.width.height.equalTo(140)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(tamagochiImage.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)

        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)

        }
        
        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)

        }
        
        riceButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(40)
            make.leading.equalTo(riceTextField.snp.trailing).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)

        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)

        }
        waterButton.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(40)
            make.leading.equalTo(waterTextField.snp.trailing).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)

        }
        
        
    }
    
    
}


