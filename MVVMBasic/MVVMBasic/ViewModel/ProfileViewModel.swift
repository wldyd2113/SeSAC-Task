//
//  ProfileViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/8/25.
//

import Foundation
import UIKit
class ProfileViewModel {
    
    var nickNameText = Obserable("")
    
    // statusLabel를 전달하기 위한 클로저
    var statusClosures : ((Bool, String, UIColor, Bool) -> ())?
    
    init() {
        nickNameText.outAction { _ in
            self.nicknameChanged()
        }
    }
    
    private func nicknameChanged() {
        do {
            let _ = try nickError(nickNameText.value)
            statusClosures?(true, "사용할 수 있는 닉네임입니다", .systemGreen, false)
        }
        catch NickNameError.emptyError {
            statusClosures?(false, "", .white, true)
        }
        catch NickNameError.particularError {
            statusClosures?(false, "@, #, $, % 특수문자 및 숫자 사용 불가", .red, false)
        }
        catch NickNameError.isStringError {
            statusClosures?(false, "닉네임에 숫자는 포함할 수 없습니다", .red, false)
        }
        catch NickNameError.outOfNicknameError {
            statusClosures?(false, "2글자 이상 10글자 미만으로 입력해주세요", .red, false)
        }
        catch {
            statusClosures?(false, "", .white, true)
        }
    }
    
    private func nickError(_ text: String) throws -> Bool {
        if text.isEmpty {
            throw NickNameError.emptyError
        }
        if text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") {
            throw NickNameError.particularError
        }
        if text.rangeOfCharacter(from: .decimalDigits) != nil {
            throw NickNameError.isStringError
        }
        if text.count < 2 || text.count >= 10 {
            throw NickNameError.outOfNicknameError
        }
        return true
    }

}
