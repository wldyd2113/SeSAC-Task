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
    let viewModel = ChangeViewMdoel()
    lazy var colletion =  UICollectionView(frame: .zero, collectionViewLayout: layout())
    let disposeBag = DisposeBag()


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
        let input = ChangeViewMdoel.Input(selectCell: colletion.rx.modelSelected(Tamagochi.self))
        let output = viewModel.transform(input: input)
        
        output.tamagochiList.bind(to: colletion.rx.items(cellIdentifier: TamagochiChangeCollectionViewCell.identifier, cellType: TamagochiChangeCollectionViewCell.self)) { row, tamagochi, cell in
            cell.image.image = UIImage(named: tamagochi.image)
            cell.nameLabel.text = tamagochi.name
        }
        .disposed(by: disposeBag)
        
        
        output.selectedTamagochi
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
