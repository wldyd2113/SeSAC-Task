//
//  SearchDetailCollectionViewCell.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import UIKit
import SnapKit
import Kingfisher
class SearchDetailCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SearchDetailCollectionViewCell"
    
    let shopImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let shopName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cofigureData(_ shop: Shopdata) {
        let url = URL(string: "\(shop.image)")
        shopImage.kf.setImage(with: url)
        shopName.text = shop.mallName
        titleLabel.text = shop.title
        priceLabel.text = shop.lprice
    }
    
}

extension SearchDetailCollectionViewCell: DesignProtocol {
    func configure() {
        contentView.addSubview(shopImage)
        shopImage.addSubview(likeButton)
        contentView.addSubview(shopName)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        shopImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(15)
            make.height.equalTo(100)
            make.width.equalTo(300)
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(shopImage).offset(-20)
            make.trailing.equalTo(shopImage).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        shopName.snp.makeConstraints { make in
            make.top.equalTo(shopImage.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(15)
            make.height.equalTo(13)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(shopName.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(15)
            make.height.equalTo(15)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(15)
            make.height.equalTo(17)
        }
    }
    
    
}

