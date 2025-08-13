
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation
import UIKit
class BMIViewModel {
    
    var heightText = Obserable("") //lazyBind로 
    
    
    var weightText = Obserable("")
    
    var outputText = Obserable("")

    var showAlert: ((String) -> ())? //inputout으로 개선해보기
    
    init() {
        heightText.outAction { _ in
            self.resultBMI()
        }
        
        weightText.outAction { _ in
            self.resultBMI()
        }
    }
    
    func resultBMI() {
        
        do {
            let _ = try bmiError(heightText: heightText.value, weightText: weightText.value)
            outputText.value = heightText.value + "," + weightText.value
        }
        catch {
            switch error {
            case .heightOutOfRange:
                showAlert?("키 범위는 200까지 입니다")
                outputText.value = "키 범위는 200까지 입니다"
            case .weightOutOfRange:
                showAlert?("몸무게 범위는 210까지 입니다")
                outputText.value = "몸무게 범위는 210까지 입니다"
            }
        }
        
    }
    
    
    func bmiError(heightText: String, weightText: String) throws(BMIError) -> Bool {
        guard Int(heightText) ?? 0 <= 200 else {
            print("키 초과")
            throw .heightOutOfRange
        }
        guard Int(weightText) ?? 0 <= 210 else {
            print("몸무게 초과")
            throw .weightOutOfRange
        }
        return true
    }
    
    
}
