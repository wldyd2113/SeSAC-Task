//
//  CityDetailViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/16/25.
//

import UIKit
import Kingfisher
class CityDetailViewController: UIViewController {

    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplain: UILabel!
    
    var listData: City = City(city_name: nil, city_english_name: nil, city_explain: nil, city_image: nil, domestic_travel: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCityUI()
    }
    
    func configureCityUI() {
        let url = URL(string: listData.city_image ?? "이미지 없음")
        detailImage.kf.setImage(with: url)
        
        cityNameLabel.text = "\(listData.city_name ?? "이름 없음")  |  \(listData.city_english_name ?? "영어이름 없음") "
        cityNameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        cityNameLabel.textAlignment = .center
        
        cityExplain.text = listData.city_explain
        cityExplain.textAlignment = .center
    }
    

}
