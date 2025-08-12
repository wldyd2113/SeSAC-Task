//
//  Obserable.swift
//  NaverSearch
//
//  Created by 차지용 on 8/12/25.
//

import Foundation

class Obserable<T> {
    
    var action: (() -> ())?
    
    var value: T {
        didSet {
            action?()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(action: @escaping () -> ()) {
        action()
        self.action = action
    }
    func lazyBind(action: @escaping () -> ()) {
        self.action = action
    }
    
}
