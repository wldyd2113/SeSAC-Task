//
//  NaverPayViewController.swift
//  SnapKitPr
//
//  Created by 차지용 on 7/21/25.
//

import UIKit
import SnapKit
class NaverPayViewController: UIViewController {
    
    let segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["맵버쉽", "현장결제", "쿠폰"])
        segment.backgroundColor = .white
        return segment
    }()
    
    let naverUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let naverImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "btn_white_paying")
        return image
    }()
    
    let xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let protectImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "잠금")
        return image
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "한번만 인증하고 \n 비밀번호 없이 결제하세요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkmark.circle.fill"), for: .normal)
        button.tintColor = .green
        return button
    }()
    
    let bottmLabel: UILabel = {
        let label = UILabel()
        label.text = "바로 결제 사용하기"
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("환인", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(segment)
        view.addSubview(naverUIView)
        naverUIView.addSubview(naverImage)
        naverUIView.addSubview(xButton)
        naverUIView.addSubview(protectImage)
        naverUIView.addSubview(bodyLabel)
        naverUIView.addSubview(checkButton)
        naverUIView.addSubview(bottmLabel)
        naverUIView.addSubview(completeButton)
        
        segment.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        
        naverUIView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.width.equalTo(200)
            make.height.equalTo(500)
        }
        
        naverImage.snp.makeConstraints { make in
            make.top.equalTo(naverUIView).offset(10)
            make.leading.equalTo(naverUIView).offset(15)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalTo(naverImage)
            make.trailing.equalTo(naverUIView).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        protectImage.snp.makeConstraints { make in
            make.top.equalTo(naverUIView).offset(80)
            make.centerX.equalTo(naverUIView)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(protectImage).offset(100)
            make.horizontalEdges.equalTo(naverUIView).inset(30)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(<#T##other: any ConstraintRelatableTarget##any ConstraintRelatableTarget#>)
        }
        
        
    }
    
}
