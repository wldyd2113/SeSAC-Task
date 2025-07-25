//
//  SearchDetailViewController.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import UIKit
import SnapKit
import Alamofire
class SearchDetailViewController: UIViewController {
    
    var searchTitle = ""
    let colletion: UICollectionView = {
        let colletion = UICollectionView()
        return colletion
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2", searchTitle)
        configure()
        configureLayout()
        c
    }
    
}
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchDetailCollectionViewCell.identifier, for: indexPath) as! SearchDetailCollectionViewCell
        return cell
    }
    
    
}

//MARK: Protocol
extension SearchDetailViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .black
        self.navigationItem.title = searchTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureLayout() {
        
    }
}
