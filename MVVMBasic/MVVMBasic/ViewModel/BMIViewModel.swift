
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation
import UIKit
class BMIViewModel {
    
    var heightText = "" {
        didSet {
            print("heightText")
            print(oldValue)
            print(heightText)
            resultBMI()
        }
    }
    
    var weightText = "" {
        didSet {
            print("weightText")
            print(oldValue)
            print(weightText)
        }
    }
    
    var outputText = "" {
        didSet {
            print("outputText")
            print(oldValue)
            print(outputText)
            colsureText?()
        }
    }

    var showAlert: ((String) -> ())?
    var colsureText: (() -> ())?
    
    func resultBMI() {
        
        do {
            let _ = try bmiError(heightText: heightText, weightText: weightText)
            outputText = heightText + "," + weightText
        }
        catch {
            switch error {
            case .heightOutOfRange:
                showAlert?("키 범위는 200까지 입니다")
                outputText = "키 범위는 200까지 입니다"
            case .weightOutOfRange:
                showAlert?("몸무게 범위는 210까지 입니다")
                outputText = "몸무게 범위는 210까지 입니다"
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
