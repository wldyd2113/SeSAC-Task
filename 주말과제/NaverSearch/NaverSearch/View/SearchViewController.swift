//
//  SearchViewController.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
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
        return image
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "쇼핑하구팡"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "영캠러의 쇼핑쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        configure()
        configureLayout()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text, text.count > 0 else {
            print("빈값을 입력하세요")
            return
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 2 else {
            print("빈값을 입력하세요")
            return
        }
        
        
        let vc = SearchDetailViewController()
        vc.searchTitle = text
        print(vc.searchTitle)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
    }
}

extension SearchViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .black
        view.addSubview(searchBar)
        view.addSubview(bodyImage)
        view.addSubview(bodyLabel)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        bodyImage.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(150)
            make.centerX.equalTo(view)
            make.height.equalTo(200)
            make.width.equalTo(300)
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyImage.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }
    
    
}
