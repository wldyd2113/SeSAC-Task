//
//  WordCountViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation

class WordCountViewModel {
    var text = Obserable("")
    
    var outputText = Obserable("")
    
    init() {
        text.outAction {_ in
            self.updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        let count = text.value.count
        outputText.value = "현재까지 \(count)글자 작성중"
    }
}
