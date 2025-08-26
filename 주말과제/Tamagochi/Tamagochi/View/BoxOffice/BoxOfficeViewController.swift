//
//  BoxOfficeViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BoxOfficeViewController: UIViewController {
    private let viewModel = BoxOfficeViewModel()
    
    let movie: BehaviorRelay<[DailyBoxOfficeList]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()
    
    let searchBar = UISearchBar()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    
    func bind() {
        
        let input = BoxOfficeViewModel.Input(searText: searchBar.rx.text.orEmpty, searTap: searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.resultText.bind(to: tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) { row, element, cell  in
            cell.titleLabel.text = "\(element.rank)위 - \(element.movieNm)"
            
        }
        .disposed(by: disposeBag)
        output.tostMessage.bind(with: self) { owner, _ in
            owner.tostMessage()
        }
        .disposed(by: disposeBag)
        
        output.showAlert.bind(with: self) { owner, _ in
            owner.showAlert()
        }
        .disposed(by: disposeBag)
    }
    func tostMessage() {
        let toastLabel = UILabel(frame: CGRect(x: 20, y: self.view.frame.size.height-100, width: view.frame.size.width-2*20, height: 50))
        toastLabel.backgroundColor = UIColor.text.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = .center
        toastLabel.text = "검색을 잘못 하셨습니다 년,월,일을 입력해주세요!!"
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.masksToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut) {
            toastLabel.alpha = 0
        } completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "통신문제발생!!", message: "데이터를 확인해주세요,와이파이를 연결해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension BoxOfficeViewController: DesginProtocol {
    func configureHirarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)

    }
    
    func configureUI() {
        view.backgroundColor = .background
        tableView.backgroundColor = .background
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

