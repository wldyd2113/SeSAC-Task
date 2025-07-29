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
        image.contentMode = .scaleAspectFill
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
        label.font = .systemFont(ofSize: 6)
        label.textColor = .lightGray
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
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
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(shopImage)
            make.trailing.equalTo(shopImage)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        shopName.snp.makeConstraints { make in
            make.top.equalTo(shopImage.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(15)
            make.height.equalTo(13)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(shopName.snp.bottom)
            make.leading.equalTo(contentView).offset(15)
            make.width.equalTo(100)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(contentView).offset(15)
        }
    }
    
    
}

