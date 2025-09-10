//
//  NetworkManger.swift
//  WeatherMap
//
//  Created by 차지용 on 9/10/25.
//

import Foundation
import Alamofire

class NetworkManger {
    static let shared = NetworkManger()
    
    func fetchRequest(lat: String, lon: String, completion: @escaping (WeatherResponse?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIKey.key)&units=metric&lang=kr"
        
        AF.request(url).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
                
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
