//
//  LottoTableViewCell.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit
import SnapKit

class LottoTableViewCell: UITableViewCell {
    
    static let identifier = "LottoTableViewCell"
    
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.text = "913회 당첨 결과"
        return label
    }()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 7 //간격을 7로줌
        stack.distribution = .fillEqually //각 내부 요소들의 너비를 동일하게 맞춰줌
        return stack
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureLayout()
        stackRandom()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stackRandom() {
        
        print(#function)
        
        for _ in 0..<6 {
            stackUI()
        }
        let plusView: UILabel = {
            let label = UILabel()
            label.text = "+"
            label.font = .systemFont(ofSize: 20)
            return label
        }()
        stackView.addArrangedSubview(plusView)
        
        stackUI()
    }
    
    func stackUI() {
        let color: [UIColor] = [.red, .blue, .green, .yellow, .orange]

        var number = Int.random(in: 1...100)
        let label = UILabel()
        label.text = "\(number)"
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = color.randomElement()
        label.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        label.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        
        stackView.addArrangedSubview(label)
    }
    
//    func configureCell(round: Int) {
//        titleLabel.text = "\(round)회 당첨 결과 "
//        print(round)
//        stackUI()
//        
//    }
    

    
    
}

//MARK: extension
extension LottoTableViewCell: DesignProtocol {
    func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.centerX.equalTo(contentView)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
            make.height.equalTo(30)
        }
    }
    
    
}
