//
//  SettingViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SettingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let tabeleView = UITableView()
    let titleList = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화하기"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    
    private func bind() {
        Observable.just(titleList)
            .bind(to: tabeleView.rx.items(cellIdentifier: SettingTableViewCell.identifier, cellType: SettingTableViewCell.self)) { row, data, cell in
                if row == 0 {
                    cell.icon.image = UIImage(systemName: "pencil")
                    cell.titleLabel.text = data
                    cell.nickName.text = UserDefaults.standard.string(forKey: UserTamagochi.nickName.rawValue)
                }
                else if row == 1 {
                    cell.icon.image = UIImage(systemName: "moon.fill")
                    cell.titleLabel.text = data
                }
                else {
                    cell.icon.image = UIImage(systemName: "trash.fill")
                    cell.titleLabel.text = data
                }
                
                cell.nextButton.rx.tap.bind(with: self) { owner, _ in
                    if row == 0 {
                        let vc = NickNameChangeViewController()
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    else if row == 1 {
                        let vc = TamagochiChangeViewController()
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    else {
                        owner.deleteAlert()
                    }
                }
                .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
    }
    
    func deleteAlert() {
        let alert = UIAlertController(
            title: "데이터 초기화",
            message: "정말 다시 처음부터 시작하실건가용?",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "아냐!", style: .cancel, handler: nil)
        let reset = UIAlertAction(title: "웅!", style: .default) { _ in
            UserDefaults.standard.removeObject(forKey: UserTamagochi.nickName.rawValue)
            UserDefaults.standard.removeObject(forKey: UserTamagochi.rice.rawValue)
            UserDefaults.standard.removeObject(forKey: UserTamagochi.water.rawValue)
            UserDefaults.standard.removeObject(forKey: UserTamagochi.level.rawValue)
            UserDefaults.standard.removeObject(forKey: UserTamagochi.selectedTamagochi.rawValue)

            
            let vc = TamagochiChangeViewController()
            vc.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

        alert.addAction(cancel)
        alert.addAction(reset)

        present(alert, animated: true)
    }
    

}

extension SettingViewController: DesginProtocol {
    func configureHirarchy() {
        view.addSubview(tabeleView)
        tabeleView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    func configureUI() {
        view.backgroundColor = .background
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]
        tabeleView.allowsSelection = false
    }
    
    func configureLayout() {
        tabeleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
