//
//  Movie.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import Foundation

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
    
}
