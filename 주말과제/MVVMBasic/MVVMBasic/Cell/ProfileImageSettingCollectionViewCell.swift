//
//  ProfileImageSettingCollectionViewCell.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/13/25.
//

import UIKit
import SnapKit
class ProfileImageSettingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileImageSettingCollectionViewCell"
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "image1"), for: .normal)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.width.height.equalTo(40)
        }
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
