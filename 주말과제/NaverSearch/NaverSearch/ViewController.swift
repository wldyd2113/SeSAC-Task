//
//  ViewController.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let nvButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색화면", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(navigationButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nvButton)
        
        nvButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    
    @objc func navigationButton() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

