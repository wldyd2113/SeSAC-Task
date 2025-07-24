//
//  LottCell.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/24/25.
//

import Foundation
import UIKit
import SnapKit
class LottLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.textColor = .black        
        self.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        self.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
