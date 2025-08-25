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
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    let movie: BehaviorRelay<[DailyBoxOfficeList]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    
    func bind() {
        movie.bind(to: tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) { row, element, cell  in
            cell.titleLabel.text = "\(element.rank)위 - \(element.movieNm)"
            
        }
        .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .flatMap { text in
                CustomObserable.getMovie(year: text)
            }
            .subscribe(with: self) { owner, value in
                owner.movie.accept(value)
            } onError: { owner, error in
                
            } onCompleted: { owner in
                
            } onDisposed: { owner in
                
            }
            .disposed(by: disposeBag)

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

