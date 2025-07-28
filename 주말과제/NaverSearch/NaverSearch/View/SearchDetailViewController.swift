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
    // .replaceingOccurrences(of:"<b></b>", with: "")
    var searchTitle = ""
//    var shop = ShopInfo(total: 0, lastBuildDate: "", items: [])
    var shop: [Shopdata] = []
    var page = 1
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemGreen
        return label
    }()
    let colletion: UICollectionView = {
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colletion.backgroundColor = .black
        return colletion
    }()
    
    let accuracyButton: UIButton = {
        let button = DetailButton()
        button.setTitle("정확도", for: .normal)
        button.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let dayButton: UIButton = {
        let button = DetailButton()
        button.setTitle("날짜순", for: .normal)
        button.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)

        return button
    }()
    
    let priceUpButton: UIButton = {
        let button = DetailButton()
        button.setTitle("가격높은순", for: .normal)
        button.addTarget(self, action: #selector(priceUpButtonTapped), for: .touchUpInside)

        return button
    }()
    
    let priceDownButton: UIButton = {
        let button = DetailButton()
        button.setTitle("가격낮은순", for: .normal)
        button.addTarget(self, action: #selector(priceDownButtonTapped), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2", searchTitle)
        configure()
        configureLayout()
        shopData(searchTitle)
        
        

    }
    //MARK: 데이터 관리
    func shopData(_ searchTitle: String, sort: String = "sim") {
        print(#function)
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchTitle)&display=30&start=\(page)&sort=\(sort)"
        let header: HTTPHeaders = ["X-Naver-Client-Id": "skLvqKWpYQN5oOWjEK9g", "X-Naver-Client-Secret": "o8KK6vOXf6"]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of:ShopInfo.self) { response in
            switch response.result {
            case .success(let value):
                self.shop.append(contentsOf: value.items)
                self.totalLabel.text = "\(value.total) 개의 검색 결과"
                self.colletion.reloadData()

                if self.page == 0 {
                    self.colletion.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: false)
                }
                
                print(value)
            case .failure(let error):
                print("에러 발생", error)
            }
        }
        
        
    }
    //MARK: 정렬 함수들
    //정확도
    @objc func accuracyButtonTapped() {
        shop.removeAll()
        page = 1
        shopData(searchTitle, sort: "sim")
        colletion.reloadData()
    }
    //날짜순
    @objc func dayButtonTapped() {
        shop.removeAll()
        page = 1
        shopData(searchTitle, sort: "date")
        colletion.reloadData()
    }
    //가격 높은순
    @objc func priceUpButtonTapped() {
        shop.removeAll()
        page = 1
        shopData(searchTitle, sort: "dsc")
        colletion.reloadData()

    }
    //가격 낮은순
    @objc func priceDownButtonTapped() {
        shop.removeAll()
        page = 1
        shopData(searchTitle, sort: "asc")
        colletion.reloadData()


    }
    
}

//MARK: Colletion
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchDetailCollectionViewCell.identifier, for: indexPath) as! SearchDetailCollectionViewCell
        let shopList = shop[indexPath.item]
        let url = URL(string: "\(shopList.image)")
        cell.shopImage.kf.setImage(with: url)
        cell.shopName.text = shopList.mallName
        cell.titleLabel.text = shopList.title.replacingOccurrences(of: "[<b></b>]", with: "", options: .regularExpression)
        cell.priceLabel.text = shopList.lprice
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (shop.count - 3) {
            page += 1
        }
        shopData(searchTitle)

    }
    
    
}

//MARK: Protocol
extension SearchDetailViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .black
        self.navigationItem.title = searchTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.addSubview(colletion)
        view.addSubview(totalLabel)
        view.addSubview(accuracyButton)
        view.addSubview(dayButton)
        view.addSubview(priceUpButton)
        view.addSubview(priceDownButton)
        
        let layout = UICollectionViewFlowLayout()
        let devieWith = UIScreen.main.bounds.width
        let cellWidth = devieWith - (8 * 2) - (8 * 2)

        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth/2)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8 //
        layout.minimumInteritemSpacing = 8 //셀사이의 간격
        layout.scrollDirection = .vertical
        
        colletion.collectionViewLayout = layout
        colletion.delegate = self
        colletion.dataSource = self
        colletion.register(SearchDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchDetailCollectionViewCell.identifier)
        

    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view).offset(15)
            make.height.equalTo(22)

        }
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        dayButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(5)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        priceUpButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(5)
            make.leading.equalTo(dayButton.snp.trailing).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        priceDownButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(5)
            make.leading.equalTo(priceUpButton.snp.trailing).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        colletion.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(accuracyButton.snp.bottom)
        }
    }
}
