//
//  SearchView.swift
//  NaverSearch
//
//  Created by 차지용 on 7/28/25.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .black
        searchBar.tintColor = .black
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        return searchBar
    }()
    let bodyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "person")
        image.contentMode = .scaleAspectFill
        return image
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "쇼핑하구팡"
        return label
    }()
    
    override func configure() {
        addSubview(searchBar)
        addSubview(bodyImage)
        addSubview(bodyLabel)
        searchBar.showsCancelButton = true
        backgroundColor = .black
 

    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        bodyImage.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(150)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(200)
            make.width.equalTo(300)
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyImage.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }

}
