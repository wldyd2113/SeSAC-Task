//
//  Obserable.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/11/25.
//

import Foundation
class Obserable<T> {
    
    private var action: ((T) -> ())?
    
    var value: T  {
        didSet {
            action?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    
    func outAction(action: @escaping (T) -> ()) {
        action(value)
        self.action = action
        
    }
}
