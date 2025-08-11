//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
     
    private let mapView = MKMapView()
    
    let viewModel = MapViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        addSeoulStationAnnotation()
        viewModel.anotations.outAction { annotations in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(annotations)
            
            guard let filterAnnotations = annotations.first  else{ return }
            let region = MKCoordinateRegion(
                center: filterAnnotations.coordinate,
                latitudinalMeters: 2000,
                longitudinalMeters: 2000
            )
            self.mapView.setRegion(region, animated: true)
        }
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        let seoulStationCoordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        let region = MKCoordinateRegion(
            center: seoulStationCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    //어노 테이션 생성
    private func addSeoulStationAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        annotation.title = "서울역"
        annotation.subtitle = "대한민국 서울특별시"
        mapView.addAnnotation(annotation)
    }
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "전체", style: .default) { _ in
            self.viewModel.showRestaurants(category: "전체")
            print("전체가 선택되었습니다.")
        }
        
        let alert2Action = UIAlertAction(title: "한식", style: .default) { _ in
            self.viewModel.showRestaurants(category: "한식")
            print("한식이 선택되었습니다.")
        }
        
        let alert3Action = UIAlertAction(title: "양식", style: .default) { _ in
            self.viewModel.showRestaurants(category: "양식")

            print("양식이 선택되었습니다.")
        }
        let alert4Action = UIAlertAction(title: "분식", style: .default) { _ in
            self.viewModel.showRestaurants(category: "분식")

            print("분식이 선택되었습니다.")
        }
        let alert5Action = UIAlertAction(title: "일식", style: .default) { _ in
            self.viewModel.showRestaurants(category: "일식")
            print("일식이 선택되었습니다.")
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(alert4Action)
        alertController.addAction(alert5Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
    
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
