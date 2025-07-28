//
//  shop.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import Foundation

struct ShopInfo: Decodable {
    let total :Int //총 갯수
    let lastBuildDate: String //날짜
    var items: [Shopdata]
}
struct Shopdata: Decodable {
    let mallName: String // 제품명
    let title: String // 제품 설명
    let lprice: String // 가격
    let image: String // 제품 이미지
}
