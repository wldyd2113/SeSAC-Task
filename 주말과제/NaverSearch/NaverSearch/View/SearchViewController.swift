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
        return searchBar
    }()
    let bodyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        return image
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.text = "중고나라"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let vc = SearchDetailViewController()
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
            make.width.equalTo(200)
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyImage.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }
    
    
}
