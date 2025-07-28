//
//  SearchViewController.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    
    override  func loadView() {
        super.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchBar.delegate = self
        view.backgroundColor = .black
        self.navigationItem.title = "영캠러의 쇼핑쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
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


