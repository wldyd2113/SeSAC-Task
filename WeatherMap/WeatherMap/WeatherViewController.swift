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
    let locationManger = CLLocationManager()
    
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
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTap), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTap), for: .touchUpInside)
        checkLocationServices()
    }
    
    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.checkLocationAuthorization()
            } else {
                self.currentDateLabel.text = "위치 서비스가 꺼져 있습니다. 설정에서 켜주세요!"
            }
        }
    }

    
    func checkLocationAuthorization() {
        var status: CLAuthorizationStatus

        if #available(iOS 14.0, *) {
            status = locationManger.authorizationStatus
        }
        else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
            
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .denied:
            DispatchQueue.main.async {
                self.currentDateLabel.text = "위치 권한이 필요합니다. 설정에서 허용해주세요."
                let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.5264, longitude: 126.8964)
                let region = MKCoordinateRegion(
                    center: defaultCoordinate,
                    latitudinalMeters: 500,
                    longitudinalMeters: 500
                )
                self.mapView.setRegion(region, animated: true)
                self.alert()
            }
        case .authorizedWhenInUse:
            locationManger.startUpdatingLocation()
        default:
            print(status)
        }
    }
    
    @objc func currentLocationButtonTap() {
        print(#function)
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        locationManger.startUpdatingLocation()
    }
    
    @objc func resetButtonTap() {
        print(#function)
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManger.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }

        switch status {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .denied:
            let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.5264, longitude: 126.8964)
            let region = MKCoordinateRegion(center: defaultCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
            weatherRequest(lat: defaultCoordinate.latitude, lon: defaultCoordinate.longitude)
            alert()
        case .authorizedWhenInUse:
            if let location = locationManger.location {
                weatherRequest(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                mapView.setRegion(region, animated: true)
            } else {
                locationManger.startUpdatingLocation()
            }
        @unknown default:
            break
        }
    }

    
    func configure() {
        view.addSubview(mapView)
        view.addSubview(currentDateLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(windspeedLabel)
        view.addSubview(humidityLabel)
        view.addSubview(currentLocationButton)
        view.addSubview(resetButton)
        
        locationManger.delegate = self
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
    
    func alert() {
        let alert = UIAlertController(
            title: "위치 권한 필요",
            message: "앱에서 위치 권한을 허용해야 현재 위치를 확인할 수 있습니다.\n설정으로 이동하시겠습니까?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    func weatherRequest(lat: Double, lon: Double) {
        NetworkManger.shared.fetchRequest(lat: "\(lat)", lon: "\(lon)") { [weak self] response in
            guard let self = self, let weather = response else { return }
            DispatchQueue.main.async {
                self.temperatureLabel.text = "현재온도: \(weather.main.temp)℃"
                self.humidityLabel.text = "습도: \(weather.main.humidity)%"
                self.windspeedLabel.text = "풍속: \(weather.wind.speed)m/s"
                
                // 날짜/시간 표시
                let date = Date(timeIntervalSince1970: TimeInterval(weather.dt))
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                self.currentDateLabel.text = formatter.string(from: date)
            }
        }
    }

}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        let region = MKCoordinateRegion(center: locations.first!.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
        weatherRequest(lat: location.coordinate.latitude, lon: location.coordinate.longitude)

        locationManger.startUpdatingLocation()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

}
