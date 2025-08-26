//
//  DesginProtocol.swift
//  Tamagochi
//
//  Created by 차지용 on 8/23/25.
//

import Foundation

//이상태로 쓰는게 좋은지 상속을해서 쓰는게 좋은지 고민해보기
protocol DesginProtocol {
    func configureHirarchy()
    func configureLayout()
}

protocol DesginProtocolUI: DesginProtocol  {
    func configureHirarchy()
    func configureUI()
    func configureLayout()
}
