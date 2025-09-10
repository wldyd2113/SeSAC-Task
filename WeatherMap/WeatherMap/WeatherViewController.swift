//
//  WeatherViewController.swift
//  WeatherMap
//
//  Created by 차지용 on 9/10/25.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit
//5a271a50327b9a021ef3cc5f04d3ca02
class WeatherViewController: ViewController {
    
    let mapView = MKMapView()
    
    let currentDateLabel = UILabel()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    let windspeedLabel = UILabel()
    
    let currentLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = false
        button.backgroundColor = .white
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = false
        button.backgroundColor = .white
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        configureLayout()
       
    }
    
    func configure() {
        view.addSubview(mapView)
        view.addSubview(currentDateLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(windspeedLabel)
        view.addSubview(humidityLabel)
        view.addSubview(currentLocationButton)
        view.addSubview(resetButton)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        currentDateLabel.text = "날씨정보를 불러오는중..."
        temperatureLabel.text = "현재온도"
        windspeedLabel.text = "풍속"
        humidityLabel.text = "습도"
    }
    
    func configureLayout() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
            
        }
        currentDateLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(currentDateLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        windspeedLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(windspeedLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(50)
        }
        
        resetButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(50)
        }

    }
    

}
