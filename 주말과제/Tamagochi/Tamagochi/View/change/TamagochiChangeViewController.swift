//
//  TamagochiMainViewController.swift
//  Tamagochi
//
//  Created by 차지용 on 8/23/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class TamagochiChangeViewController: UIViewController {
    
    lazy var colletion =  UICollectionView(frame: .zero, collectionViewLayout: layout())
    let disposeBag = DisposeBag()
    let tamagochiList: BehaviorSubject<[Tamagochi]> = {
        let name = UserDefaults.standard.string(forKey: UserTamagochi.nickName.rawValue)
        var list: [Tamagochi] = []
        list.append(Tamagochi(name: name ?? "따금따금 다마고", image: "1-6"))
        list.append(Tamagochi(name: name ?? "방실방실 다마고치", image: "2-6"))
        list.append(Tamagochi(name: name ?? "따금따금 다마고치", image: "3-6"))
        
        for _  in 4...20 {
            list.append(Tamagochi(name: "준비중", image: "noImage"))
        }
        
        return BehaviorSubject(value: list)
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHirarchy()
        configureUI()
        configureLayout()
        bind()
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        return layout
    }
    func bind() {
        tamagochiList.bind(to: colletion.rx.items(cellIdentifier: TamagochiChangeCollectionViewCell.identifier, cellType: TamagochiChangeCollectionViewCell.self)) { row, tamagochi, cell in
            cell.image.image = UIImage(named: tamagochi.image)
            cell.nameLabel.text = tamagochi.name
        }
        .disposed(by: disposeBag)
        
        colletion.rx.modelSelected(Tamagochi.self)
            .bind(with: self) { owner, tamagochi in
                let detailVC = TamagochiDetailViewController(tamagochi: tamagochi)
                owner.present(detailVC, animated: true)
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
}

extension TamagochiChangeViewController: DesginProtocol {

    func configureHirarchy() {
        view.addSubview(colletion)
        colletion.register(TamagochiChangeCollectionViewCell.self, forCellWithReuseIdentifier: TamagochiChangeCollectionViewCell.identifier)
    }
    
    func configureUI() {
        view.backgroundColor = .background
        navigationItem.title = "다마고치 선택하기"
       
    }
    
    func configureLayout() {
        colletion.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
