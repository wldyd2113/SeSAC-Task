//
//  BoxOfficeTableViewCell.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    static let identifier = "BoxOfficeTableViewCell"
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .background
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

