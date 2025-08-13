//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by 차지용 on 8/11/25.
//

import Foundation
import MapKit

class MapViewModel {
    //Mapkit을 import안하고 데이터 전달받는 방식
    //Mapkit문서 보기
    var anotations = Obserable<[MKAnnotation]>([])
    
    
    func showRestaurants(category: String) {
        let restaurants: [Restaurant]
        
        var newAnnotations: [MKAnnotation]  = []
        
        if category == "전체" {
            restaurants = RestaurantList.restaurantArray
        }
        else {
            restaurants =  RestaurantList.restaurantArray.filter { $0.category == category}
        }
        for restaurant in restaurants {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            annotation.title = restaurant.name
            annotation.subtitle = restaurant.address
            newAnnotations.append(annotation)
        }
        anotations.value = newAnnotations
        print("카테고리:", category)

    }
}
