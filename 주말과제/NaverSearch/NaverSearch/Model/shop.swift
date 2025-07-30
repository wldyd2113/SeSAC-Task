//
//  shop.swift
//  NaverSearch
//
//  Created by 차지용 on 7/25/25.
//

import Foundation

struct ShopInfo: Codable {
    let total :Int //총 갯수
    let lastBuildDate: String //날짜
    var items: [Shopdata]
}

struct Shopdata: Codable {
    let mallName: String // 제품명
    let title: String // 제품 설명
    let lprice: String // 가격
    let image: String // 제품 이미지
    
    //decoding해서 ShopInfo재구성
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mallName = try container.decode(String.self, forKey: .mallName)
        let titleDecode = try container.decode(String.self, forKey: .title)
        self.title = titleDecode.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression)
        self.lprice = try container.decode(String.self, forKey: .lprice)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    enum CodingKeys: String, CodingKey {
        case mallName
        case title = "title"
        case lprice
        case image
    }
     
}



