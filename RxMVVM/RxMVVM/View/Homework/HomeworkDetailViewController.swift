//
//  HomeworkDetailViewController.swift
//  RxMVVM
//
//  Created by 차지용 on 8/21/25.
//

import UIKit

class HomeworkDetailViewController: UIViewController {
    var nv: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        navigationItem.title = nv
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black] 

    }
    



}
