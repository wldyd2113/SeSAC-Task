//
//  CityCollectionViewCell.swift
//  CityColletoion
//
//  Created by 차지용 on 7/17/25.
//

import UIKit
import Kingfisher

class City2CollectionViewCell: UICollectionViewCell {


    @IBOutlet var cityImage: UIImageView!
    
    @IBOutlet var cityEnLabel: UILabel!
    
    @IBOutlet var cityNameLabel: UILabel!
    

    
    func configureCell(cityIndexPath: City) {
        let url = URL(string: cityIndexPath.city_image!)
        
        cityNameLabel.text = cityIndexPath.city_explain
        cityNameLabel.textColor = .lightGray
        cityNameLabel.font = .systemFont(ofSize: 10)

        
        cityEnLabel.text = (cityIndexPath.city_english_name ?? "") + "  |  " + (cityIndexPath.city_name ?? "")
        cityEnLabel.textColor = .black
        cityEnLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        cityImage.kf.setImage(with: url)
        cityImage.layer.cornerRadius = cityImage.frame.width / 2
        cityImage.clipsToBounds = true

    }
}
