//
//  SimpleTableViewExampleViewController.swift
//  RxSampleProject
//
//  Created by 차지용 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController, UITableViewDelegate {
    
    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(SimpleTableViewExampleTableViewCell.self, forCellReuseIdentifier: "SimpleTableViewExampleTableViewCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let items = Observable.just(
            (0..<20).map { "\($0)"}
        )
        items.bind(to: tableView.rx.items(cellIdentifier: "SimpleTableViewExampleTableViewCell", cellType: SimpleTableViewExampleTableViewCell.self)) {
            (row, elemt, cell) in
            cell.bodyLabel.text = "\(elemt) @ row \(row)"
            cell.button.setTitle(">", for: .normal)

        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(with: self) { onwer, value in
                onwer.alert(value)
                print("modelSelected")
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .subscribe(with: self) { onwer, indexPath in
                print("itemAccessoryButtonTapped")
                onwer.alert(indexPath.description)
            }
            .disposed(by: disposeBag)
        
    }
    
    func alert(_ message: String) {
        //1. 밑바탕
        let alert = UIAlertController(title: "Rx연습하기", message: "\(message) RxSwift입니다", preferredStyle: .alert)
        //2.
        let ok = UIAlertAction(title: "확인", style: .default)
        
        //3. addAction 순서대로 붙음
        alert.addAction(ok)
        
        
        //4. 화면에 띄워주는 작업
        present(alert, animated: true)
    }
}

