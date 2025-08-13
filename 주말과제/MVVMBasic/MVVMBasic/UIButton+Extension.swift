//
//  UIButton+Extension.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/11/25.
//

import Foundation
import UIKit

extension UIButton {
    
    func setButton() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
    }
    
}
