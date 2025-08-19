//
//  SimpleTableViewExampleTableViewCell.swift
//  RxSampleProject
//
//  Created by 차지용 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    let bodyLabel = UILabel()
    let button = UIButton()
    
    var buttonEvent: (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(button)
        button.setTitleColor(.black, for: .normal)
        

        button.rx.tap.subscribe(with: self, onNext: { onwer, _ in
            onwer.buttonEvent?()
        }, onError: { _, error in
            print(error)
        }, onCompleted: { _ in
            print("onCompleted")
        }, onDisposed: { _ in
            print("onDisposed")
        })
        .disposed(by: disposeBag)
        
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
        }
        button.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-8)
        }
        
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
