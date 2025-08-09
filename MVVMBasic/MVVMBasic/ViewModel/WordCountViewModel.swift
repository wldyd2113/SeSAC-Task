//
//  WordCountViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation

class WordCountViewModel {
    var text = "" {
        didSet {
            print("text")
            print(oldValue)
            print(text)
            updateCharacterCount()
        }
    }
    
    var outputText = "" {
        didSet {
            print("outputText")
            print(oldValue)
            print(outputText)
            senderData?()
        }
    }
    
    var senderData: (() ->())?
    
    private func updateCharacterCount() {
        let count = text.count
        outputText = "현재까지 \(count)글자 작성중"
    }
}
