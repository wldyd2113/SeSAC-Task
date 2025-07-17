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
        cityNameLabl.textColor = .lightGray
        cityNameLabl.font = .systemFont(ofSize: 15)

        
        cityEnLabel.text = (cityIndexPath.city_english_name ?? "") + "  |  " + (cityIndexPath.city_name ?? "")
        cityEnLabel.textColor = .black
        cityEnLabel.font = .systemFont(ofSize: 17, weight: .bold)

        
        cityImage.kf.setImage(with: url)
        cityImage.contentMode = .scaleAspectFill
        
    }

}
