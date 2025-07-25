//
//  shop.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import Foundation

struct shopInfo: Decodable {
    let items: [Shopdata]
}
struct Shopdata: Decodable {
    let mallName: String
    let title: String
    let lprice: String
    let image: String
}
