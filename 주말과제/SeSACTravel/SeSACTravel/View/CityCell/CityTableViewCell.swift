//
//  CityTableViewCell.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/15/25.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {

    @IBOutlet var cityImage: UIImageView!
    @IBOutlet var cityEnLabel: UILabel!
    @IBOutlet var cityNameLabl: UILabel!
    
    func configureCityCell(cityIndexPath: City) {
        let url = URL(string: cityIndexPath.city_image ?? "")
        
        cityNameLabl.text = cityIndexPath.city_explain
        cityNameLabl.textColor = .white
        cityNameLabl.font = .systemFont(ofSize: 15)
        cityNameLabl.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        
        cityEnLabel.text = (cityIndexPath.city_english_name ?? "") + "  |  " + (cityIndexPath.city_name ?? "")
        cityEnLabel.textColor = .white
        cityEnLabel.font = .systemFont(ofSize: 17, weight: .bold)
//        cityEnLabel.backgroundColor = .clear

        
        cityImage.kf.setImage(with: url)
        cityImage.contentMode = .scaleAspectFill
        
    }
}
