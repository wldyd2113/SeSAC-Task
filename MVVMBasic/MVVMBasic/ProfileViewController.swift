//
//  ProfileViewController.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    let profile: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!,
        UIImage(named: "image7")!,
        UIImage(named: "image8")!,
        UIImage(named: "image9")!,
        UIImage(named: "image10")!,
        UIImage(named: "image11")!,
        UIImage(named: "image12")!
    ]
    
    var selectedEI: String?
    var selectedSN: String?
    var selectedTF: String?
    var selectedJP: String?
    var nickNameCheck =  false
    
    let viewModel = ProfileViewModel()

    
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
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let ebutton: UIButton = {
        let button = UIButton()
        button.setTitle("E", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        
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
        button.layer.cornerRadius = 20
        
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
        button.layer.cornerRadius = 20
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
        button.layer.cornerRadius = 20
        
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
        button.layer.cornerRadius = 20
        
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
        button.layer.cornerRadius = 20
        
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
        button.layer.cornerRadius = 20
        
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
        button.layer.cornerRadius = 20
        
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
        button.backgroundColor = .lightGray
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureHierarchy()
        configureLayout()
        
        if let randomImage = profile.randomElement() {
            profileImage.image = randomImage
        }
        
        viewModel.statusClosures = { check, text, color, isHidden  in
            self.nickNameCheck = check
            self.statusLabel.text = text
            self.statusLabel.textColor = color
            self.statusLabel.isHidden = isHidden
            self.completeStatus()
            
        }
    }
    
    
    
    //테두리 없애기
    func textFieldUI(_ textField: UITextField) {
        textField.borderStyle = .line
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 1)
        border.backgroundColor = UIColor.gray.cgColor
        textField.layer.addSublayer(border)
    }
    
    //선택
    @objc func eiButtonClicked(_ sender: UIButton) {
        if sender == ebutton {
            selectedEI = "E"
            ebutton.backgroundColor = .systemBlue
            ebutton.setTitleColor(.white, for: .normal)
            ibutton.backgroundColor = .white
            ibutton.setTitleColor(.lightGray, for: .normal)
        }
        else if sender == ibutton {
            selectedEI = "I"
            ibutton.backgroundColor = .systemBlue
            ibutton.setTitleColor(.white, for: .normal)
            ebutton.backgroundColor = .white
            ebutton.setTitleColor(.lightGray, for: .normal)
        }
        completeStatus()
    }
    
    @objc func snButtonClicked(_ sender: UIButton) {
        if sender == sbutton {
            selectedSN = "S"
            sbutton.backgroundColor = .systemBlue
            sbutton.setTitleColor(.white, for: .normal)
            nbutton.backgroundColor = .white
            nbutton.setTitleColor(.lightGray, for: .normal)
        } else if sender == nbutton {
            selectedSN = "N"
            nbutton.backgroundColor = .systemBlue
            nbutton.setTitleColor(.white, for: .normal)
            sbutton.backgroundColor = .white
            sbutton.setTitleColor(.lightGray, for: .normal)
        }
        completeStatus()
    }

    @objc func tfButtonClicked(_ sender: UIButton) {
        if sender == tbutton {
            selectedTF = "T"
            tbutton.backgroundColor = .systemBlue
            tbutton.setTitleColor(.white, for: .normal)
            fbutton.backgroundColor = .white
            fbutton.setTitleColor(.lightGray, for: .normal)
        } else if sender == fbutton {
            selectedTF = "F"
            fbutton.backgroundColor = .systemBlue
            fbutton.setTitleColor(.white, for: .normal)
            tbutton.backgroundColor = .white
            tbutton.setTitleColor(.lightGray, for: .normal)
        }
        completeStatus()
    }

    @objc func jpButtonClicked(_ sender: UIButton) {
        if sender == jbutton {
            selectedJP = "J"
            jbutton.backgroundColor = .systemBlue
            jbutton.setTitleColor(.white, for: .normal)
            pbutton.backgroundColor = .white
            pbutton.setTitleColor(.lightGray, for: .normal)
        } else if sender == pbutton {
            selectedJP = "P"
            pbutton.backgroundColor = .systemBlue
            pbutton.setTitleColor(.white, for: .normal)
            jbutton.backgroundColor = .white
            jbutton.setTitleColor(.lightGray, for: .normal)
        }
        completeStatus()
    }
    
    //완료
    @objc func completeButtonClicked() {
        print(#function)

    }
    
    func completeStatus() {
        if selectedEI != nil && selectedSN != nil && selectedTF != nil && selectedJP != nil && nickNameCheck == true {
            completeButton.backgroundColor = .systemBlue
            completeButton.isEnabled = true
        } else {
            completeButton.isEnabled = false
            completeButton.backgroundColor = .lightGray
        }
    }
    @objc func nicknameChanged() {
        guard let nicknamke = nicknameTextField.text else { return }

        viewModel.nickNameText = nicknamke
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
        
        nicknameTextField.addTarget(self, action: #selector(nicknameChanged), for: .editingChanged)
        ebutton.addTarget(self, action: #selector(eiButtonClicked(_:)), for: .touchUpInside)
        ibutton.addTarget(self, action: #selector(eiButtonClicked(_:)), for: .touchUpInside)
        
        sbutton.addTarget(self, action: #selector(snButtonClicked(_:)), for: .touchUpInside)
        nbutton.addTarget(self, action: #selector(snButtonClicked(_:)), for: .touchUpInside)
        
        tbutton.addTarget(self, action: #selector(tfButtonClicked(_:)), for: .touchUpInside)
        fbutton.addTarget(self, action: #selector(tfButtonClicked(_:)), for: .touchUpInside)
        
        jbutton.addTarget(self, action: #selector(jpButtonClicked(_:)), for: .touchUpInside)
        pbutton.addTarget(self, action: #selector(jpButtonClicked(_:)), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: UIControl.Event.touchUpInside)
    }
    
    func configureLayout() {
        let buttons = [ebutton, ibutton, sbutton, nbutton, tbutton, fbutton, jbutton, pbutton]
        
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
        for button in buttons {
            button.snp.makeConstraints { make in
                make.width.height.equalTo(40)
                
            }
        }
        for button in buttons {
            button.layer.cornerRadius = 20
            
            button.layer.masksToBounds = true
        }
    }
    

    
}
