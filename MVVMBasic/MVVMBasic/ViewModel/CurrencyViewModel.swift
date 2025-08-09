//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation

class CurrencyViewModel {
    var rateText: String? = "" {
        didSet {
            print("amountText")
            print(oldValue)
            print(rateText)
            convertButtonTapped()
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
    
    var senderData: (() -> ())?
    
    private func convertButtonTapped() {
        guard let amountText = rateText,
              let amount = Double(amountText) else {
            outputText = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
    
}
