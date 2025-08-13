//
//  ProfileImageSettingViewController.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/13/25.
//

import UIKit
import SnapKit

class ProfileImageSettingViewController: UIViewController {
    
    let viewModel = ProfileImageViewModel()
    let profile: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!,
        UIImage(named: "image7")!,
        UIImage(named: "image8")!,
        UIImage(named: "image9")!,
        UIImage(named: "image10")!,
        UIImage(named: "image11")!,
        UIImage(named: "image12")!
    ]
    
    let profileImage: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 5
        button.setImage(UIImage(named: "image1"), for: .normal)
        return button
    }()
    
    lazy var colletionView: UICollectionView = {
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        colletion.delegate = self
        colletion.dataSource = self
        colletion.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier)
        return colletion
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configuare()
        configureLayout()
        profileImage.setImage(viewModel.input.userImage.value, for: .normal)
        
        let layout = UICollectionViewFlowLayout()
        let devieWith = UIScreen.main.bounds.width
        let cellWidth = devieWith

        layout.itemSize = CGSize(width: cellWidth / 5, height: cellWidth / 5)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.minimumLineSpacing = 4 //
        layout.minimumInteritemSpacing = 4 //셀사이의 간격
        layout.scrollDirection = .vertical
        colletionView.collectionViewLayout = layout

    }
    
    func configuare() {
        view.addSubview(profileImage)
        view.addSubview(colletionView)
    }
    
    func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(150)
        }
        
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileImage.layer.cornerRadius = 75
        profileImage.layer.masksToBounds = true
    }

}
extension ProfileImageSettingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.identifier, for: indexPath) as! ProfileImageSettingCollectionViewCell
        let profileImage = profile[indexPath.item]
        cell.button.setImage(profileImage, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
 
    }
}
