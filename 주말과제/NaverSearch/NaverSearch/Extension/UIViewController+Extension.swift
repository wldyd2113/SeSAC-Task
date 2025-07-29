//
//  UIViewController+Extension.swift
//  NaverSearch
//
//  Created by 차지용 on 7/29/25.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String, okMessage: String) {
        //1. 밑바탕
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //2.
        let ok = UIAlertAction(title: okMessage, style: .default)

        //3. addAction 순서대로 붙음
        alert.addAction(ok)


        //4. 화면에 띄워주는 작업
        present(alert, animated: true)
    }
}
