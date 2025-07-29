//
//  HorizontalCollectionViewCell.swift
//  NaverSearch
//
//  Created by 차지용 on 7/29/25.
//

import UIKit
import SnapKit
import Kingfisher

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HorizontalCollectionViewCell"
    
    let shopImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HorizontalCollectionViewCell: DesignProtocol {
    func configure() {
        contentView.addSubview(shopImage)
    }
    
    func configureLayout() {
        shopImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(15)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
    }
    
    
}
