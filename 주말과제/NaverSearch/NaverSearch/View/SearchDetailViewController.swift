//
//  SearchDetailViewController.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import UIKit
import SnapKit
import Kingfisher
class SearchDetailViewController: UIViewController {
    // .replaceingOccurrences(of:"<b></b>", with: "")
//    var shopTotal = ShopInfo(total: 0, lastBuildDate: "", items: [])
//    var start = 1
//    var naverPage = false
    
    let viewModel = SearchDetailViewModel()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemGreen
        return label
    }()
    
    let colletionvertical: UICollectionView = {
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colletion.backgroundColor = .black
        return colletion
    }()
    
    let collectionHorizontal: UICollectionView = {
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colletion.backgroundColor = .black
        return colletion
    }()
    
    lazy var accuracyButton: UIButton = {//이프로퍼티가
        let button = DetailButton()
        button.setTitle("정확도", for: .normal)
        button.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside) //
        return button
    }()
    
    lazy var dayButton: UIButton = {
        let button = DetailButton()
        button.setTitle("날짜순", for: .normal)
        button.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var priceUpButton: UIButton = {
        let button = DetailButton()
        button.setTitle("가격높은순", for: .normal)
        button.addTarget(self, action: #selector(priceUpButtonTapped), for: .touchUpInside)
        
        return button
    }()
    //1111
    lazy var priceDownButton: UIButton = { //let 으로 선언했을때 self에 오류 메세지가 뜨는 이유는 priceDownButton이변수가 self즉 SearchDetailViewController보다 먼저 초기화가 되서 lazy var를 사용하여 SearchDetailViewController보다 늦게 초기화 되게
        let button = DetailButton()
        button.setTitle("가격낮은순", for: .normal)
        button.addTarget(self, action: #selector(priceDownButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2", viewModel.input.searchText.value)
        configure()
        configureLayout()
        viewModelbind()

    }
    
    func viewModelbind() {
        viewModel.input.searchData.value = ()
        viewModel.output.total.bind {
            self.totalLabel.text = self.viewModel.output.total.value
        }
        viewModel.output.searchData.bind {
            
            self.colletionvertical.reloadData()
        }
        viewModel.output.macData.bind {
            self.collectionHorizontal.reloadData()
        }
    }
    
    //MARK: 정렬 함수들
    //정확도
    @objc func accuracyButtonTapped() {
        viewModel.sortAccuracy()
        colletionvertical.reloadData()
    }
    //날짜순
    @objc func dayButtonTapped() {
        viewModel.sortDay()
        colletionvertical.reloadData()
    }
    //가격 높은순
    @objc func priceUpButtonTapped() {
        viewModel.sortPriceUp()
        colletionvertical.reloadData()
        
    }
    //가격 낮은순
    @objc func priceDownButtonTapped() {
        viewModel.sortPriceDown()
        colletionvertical.reloadData()
    }
    
}

//MARK: Colletion
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colletionvertical{
            return viewModel.output.shopData.value.count
        } else {
            return viewModel.output.mac.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colletionvertical{
            let cell = colletionvertical.dequeueReusableCell(withReuseIdentifier: SearchDetailCollectionViewCell.identifier, for: indexPath) as! SearchDetailCollectionViewCell
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let shopList = viewModel.output.shopData.value[indexPath.item]
            let url = URL(string: "\(shopList.image)")
            cell.shopImage.kf.setImage(with: url)
            cell.shopName.text = shopList.mallName
            cell.titleLabel.text = shopList.title/*.replacingOccurrences(of: "[<b></b>]", with: "", options: .regularExpression)*/
            
            cell.priceLabel.text = numberFormatter.string(from: NSNumber(value: Int(shopList.lprice)!)) ?? "0"
            print(indexPath.item ,cell.priceLabel.text ?? "값 없음")
            return cell
        }
        else {
            let cell = collectionHorizontal.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
            let shopList = viewModel.output.mac.value[indexPath.item]
            let url = URL(string: "\(shopList.image)")
            cell.shopImage.kf.setImage(with: url)
            return cell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item == (viewModel.ouptputShopData.value.count - 1) {
//            if start + 30 > 1000 || start + 30 > shopTotal.total { // shopTotal.total > 1000
//                alert(title: "마지막 페이지", message: "마지막 페이지입니다", okMessage: "확인")
//                return
//            }
//            start += 30
//            //            shopData(viewModel.inputSearchText.value)
//            
//            print(indexPath,"페이지")
//            
//        }
//    }
    
}

//MARK: Protocol
extension SearchDetailViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .black
        
        self.navigationItem.title = viewModel.input.searchText.value
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.addSubview(colletionvertical)
        view.addSubview(collectionHorizontal)
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
        layout.minimumLineSpacing = 16 //
        layout.minimumInteritemSpacing = 16 //셀사이의 간격
        layout.scrollDirection = .vertical
        colletionvertical.collectionViewLayout = layout
        colletionvertical.delegate = self
        colletionvertical.dataSource = self
        colletionvertical.tag = 1
        colletionvertical.register(SearchDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchDetailCollectionViewCell.identifier)
        
        
        let layout2 = UICollectionViewFlowLayout()
        let devieWith2 = UIScreen.main.bounds.width //??
        
        let cellWidth2 = devieWith2
        layout2.itemSize = CGSize(width: cellWidth2/2, height: cellWidth2)
        layout2.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout2.minimumLineSpacing = 8 //
        layout2.minimumInteritemSpacing = 8 //셀사이의 간격
        layout2.scrollDirection = .horizontal
        collectionHorizontal.collectionViewLayout = layout2
        collectionHorizontal.delegate = self
        collectionHorizontal.dataSource = self
        collectionHorizontal.tag = 2
        collectionHorizontal.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        
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
        
        colletionvertical.snp.makeConstraints { make in
            make.top.equalTo(accuracyButton.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view).offset(-200)
            
        }
        collectionHorizontal.snp.makeConstraints { make in
            make.top.equalTo(colletionvertical.snp.top).offset(500)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(350)
            
        }
    }
}
