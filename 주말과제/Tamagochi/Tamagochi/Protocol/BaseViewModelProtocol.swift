//
//  BaseViewModelProtocol.swift
//  Tamagochi
//
//  Created by 차지용 on 8/26/25.
//

import Foundation

protocol BaseViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
