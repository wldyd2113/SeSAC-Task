//
//  Weather.swift
//  WeatherMap
//
//  Created by 차지용 on 9/10/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let wind: Wind
    let dt: Int
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
}
