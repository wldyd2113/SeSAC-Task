//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation

class AgeViewModel {
    
    var ageText = Obserable("")
    
    var outputText = Obserable("")
    
    init()  {
        ageText.outAction { _ in
            self.resultText()
        }
    }
    
    var colsuerText: (()->())?
    
    private func resultText() {
//        guard let textAge = ageText else { return }
        do {
            let _ = try userText(text: ageText.value)
            outputText.value = ageText.value
        }
        catch BoxOfficeError.isEmptySpace {
            outputText.value = "1~100 사이의 나이를 입력해주세요"
        }
        catch BoxOfficeError.isInt {
            outputText.value = "숫자를 입력해주세요"
        }
        catch BoxOfficeError.outOfrange {
            outputText.value = "범위에 해당이 안됩니다"
        }
        catch {
            outputText.value = "error"
        }

    }
    
    private func userText(text: String) throws -> Bool {
        guard !(text.isEmpty) else {
            print("빈 문자")
            throw BoxOfficeError.isEmptySpace
        }
        guard Int(text) != nil else {
            print("숫자가 아닙니다")
            throw BoxOfficeError.isInt
        }
        
        guard Int(text) ?? 0 >= 1 && Int(text) ?? 0 <= 100 else {
            print("범위 초과")
            throw BoxOfficeError.outOfrange
        }

        return true
    }
}
