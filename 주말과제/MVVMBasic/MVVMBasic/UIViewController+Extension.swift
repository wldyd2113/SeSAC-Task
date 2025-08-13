//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/7/25.
//

import UIKit
extension UIViewController {
    func setLabel<T: UIView>(label: T) {
        label.backgroundColor = .systemBrown
    }
    
    func setButton<T: UIView>(_ button: T) {
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.backgroundColor = .black
    }
}
