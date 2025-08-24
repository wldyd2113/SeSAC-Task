//
//  TamagochiDetailViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class TamagochiDetailViewController: UIViewController {
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.layer.cornerRadius = 16
        return view
    }()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: tamagochi.image)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = tamagochi.name
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = """
        저는 \(tamagochi.name) 입니다. 키는 2cm, 몸무게는 150g이에요.
        성격은 소심하지만 먹을 땐 용감해요.
        열심히 키워주시면 멋지게 성장할 겁니다.
        반가워요 주인님!!!
        """
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let cancelButton = UIButton(type: .system)
    let confirmButton = UIButton(type: .system)
    
    let tamagochi: Tamagochi
    
    let disposeBag = DisposeBag()
    
    init(tamagochi: Tamagochi) {
        self.tamagochi = tamagochi
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    
    func bind() {
        cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind(with: self) { owner, _ in
                if let presentingVC = self.presentingViewController as? UINavigationController {
                    owner.dismiss(animated: true) {
                        let vc = TamagochiViewController()
                        let sender = self.tamagochi.image.split(separator: "-").first ?? "1"
                        let vm = TamagochiViewModel()
                        vm.snederImage = String(sender)
                        vc.viewModel = vm
                        presentingVC.pushViewController(vc, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    
    }

}

extension TamagochiDetailViewController: DesginProtocol {
    
    func configureHirarchy() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(cancelButton)
        containerView.addSubview(confirmButton)
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cancelButton.setTitle("취소", for: .normal)
        confirmButton.setTitle("변경하기", for: .normal)
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(140)
            make.bottom.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(140)
        }
    }

}
