//
//  CityCollectionViewCell.swift
//  CityColletoion
//
//  Created by 차지용 on 7/17/25.
//

import UIKit
import Kingfisher
class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cityImage: UIImageView!
    
    @IBOutlet var cityEnLabel: UILabel!
    
    @IBOutlet var cityNameLabl: UILabel!

    func configureCell(cityIndexPath: City) {
        let url = URL(string: cityIndexPath.city_image ?? "")
        
        cityNameLabl.text = cityIndexPath.city_explain
        cityNameLabl.textColor = .lightGray
        cityNameLabl.font = .systemFont(ofSize: 10)

        
        cityEnLabel.text = (cityIndexPath.city_english_name ?? "") + "  |  " + (cityIndexPath.city_name ?? "")
        cityEnLabel.textColor = .black
        cityEnLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        cityImage.kf.setImage(with: url)
        print(cityImage.kf.setImage(with: url) ?? "이미지 없음")
    }
}
