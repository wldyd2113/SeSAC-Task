//
//  Movie.swift
//  SeSAC7Week4Codebase
//
//  Created by Jack on 7/23/25.
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
