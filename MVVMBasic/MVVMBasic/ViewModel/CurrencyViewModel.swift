//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation

class CurrencyViewModel {
    var rateText = Obserable("")
    
    var outputText = Obserable("")
    
    init() {
        rateText.outAction { _ in
            self.convertButtonTapped()
        }
    }
    
    var senderData: (() -> ())?
    
    private func convertButtonTapped() {
        let amountText = rateText.value
        guard let amount = Double(amountText) else {
            outputText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
    
}
