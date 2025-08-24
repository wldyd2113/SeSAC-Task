//
//  SettingTableViewCell.swift
//  Tamagochi
//
//  Created by 차지용 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class SettingTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let identifier = "SettingTableViewCell"
    
    let icon = UIImageView()
    let titleLabel = UILabel()
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.setTitleColor(.text, for: .normal)
        return button
    }()
    let nickName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHirarchy()
        configureUI()
        configureLayout()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingTableViewCell: DesginProtocol {
    func configureHirarchy() {
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nextButton)
        contentView.addSubview(nickName)

    }
    
    func configureUI() {
        icon.tintColor = .text
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    func configureLayout() {
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(icon.snp.trailing).offset(8)
        }
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
        }
        nickName.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(nextButton.snp.leading).offset(-8)

        }
    }
    
    
}
