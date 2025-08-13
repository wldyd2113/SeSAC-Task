//
//  ProfileImageViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/13/25.
//

import Foundation
import UIKit
final class ProfileImageViewModel {
    struct Input {
        var userImage: Obserable<UIImage?> = Obserable(nil)
    }
    var input: Input
    init() {
        input = Input()
    }
}
