//
//  onBoardingViewController.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/10/25.
//

import UIKit
import SnapKit
class OnBoardingViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "프로필!!!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "OnBoarding"
        view.backgroundColor = ._186_FF_2
        DispatchQueue .main.asyncAfter(deadline: .now() + 2, execute: {
            let vc = ProfileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    


}
