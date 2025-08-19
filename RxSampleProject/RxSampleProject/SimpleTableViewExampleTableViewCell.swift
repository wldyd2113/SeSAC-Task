//
//  SimpleTableViewExampleTableViewCell.swift
//  RxSampleProject
//
//  Created by 차지용 on 8/19/25.
//

import UIKit
import SnapKit

class SimpleTableViewExampleTableViewCell: UITableViewCell {
    
    let bodyLabel = UILabel()
    let button = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(button)
        
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
        }
        button.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-8)
        }
        
    }
    
    @objc func buttonTapped() {
        print(#function)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
