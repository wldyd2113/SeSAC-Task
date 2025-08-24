//
//  TamagochiMainCollectionViewCell.swift
//  Tamagochi
//
//  Created by 차지용 on 8/23/25.
//

import UIKit
import SnapKit

class TamagochiChangeCollectionViewCell: UICollectionViewCell {
    static let identifier = "TamagochiChangeCollectionViewCell"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 2
        image.layer.borderColor =  UIColor.text.cgColor
        image.layer.masksToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .text
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.text.cgColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHirarchy()
        configureUI()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TamagochiChangeCollectionViewCell: DesginProtocol {
    func configureHirarchy() {
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
    }
    
    func configureUI() {
        
    }
    
    func configureLayout() {
        image.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.width.height.equalTo(100)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.width.equalTo(100)
        }
    }
    
    
}
