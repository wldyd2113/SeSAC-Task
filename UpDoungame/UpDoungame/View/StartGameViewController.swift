//
//  StartGameViewController.swift
//  UpDoungame
//
//  Created by 차지용 on 7/22/25.
//

import UIKit
import SnapKit
class StartGameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var UpDownNumber: Int = 0
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UP DOWN"
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "시도 횟수: "
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let UpDownCollection: UICollectionView = {
        let collection = UICollectionView()
        return collection
    }()
    
    let complet: UIButton = {
        let button = UIButton()
        button.setTitle("결과확인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(completButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        UpDownCollection.delegate = self
        UpDownCollection.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let devieWidth = UIScreen.main.bounds.width
        let cellWidth = devieWidth - (20*5) - (20*3)
        layout.itemSize = CGSize(width: cellWidth/5, height: devieWidth/5)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        UpDownCollection.collectionViewLayout
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        UpDownCollection.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(400)
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UpDownNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    @objc func completButtonTapped() {
        
    }


}
