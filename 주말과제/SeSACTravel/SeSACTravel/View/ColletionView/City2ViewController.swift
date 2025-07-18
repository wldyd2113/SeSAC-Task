//
//  CityViewController.swift
//  CityColletoion
//
//  Created by 차지용 on 7/17/25.
//

import UIKit
import Kingfisher

class City2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var city = CityInfo().city
    @IBOutlet var cityColletionView: UICollectionView!
    
    @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: "City2CollectionViewCell", bundle: nil)
        cityColletionView.register(xib, forCellWithReuseIdentifier: "City2CollectionViewCell")
        
        cityColletionView.delegate = self
        cityColletionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let devieWith = UIScreen.main.bounds.width
        let cellWidth = devieWith - (16 * 2) - (16 * 4)

        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16 //
        layout.minimumInteritemSpacing = 16 //셀사이의 간격
        layout.scrollDirection = .vertical
        cityColletionView.collectionViewLayout = layout

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return city.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cityList = city[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "City2CollectionViewCell", for: indexPath) as! City2CollectionViewCell
        cell.configureCell(cityIndexPath: cityList)

        return cell
    }
    
    
//    @IBAction func everyButtonChecked(_ sender: UIButton) {
//        var filter: [City] = []
//        
//        let cityTotal = CityInfo().city
//        
//        for city in cityTotal {
//            filter.append(city)
//        }
//        city = filter
//        cityColletionView.reloadData()
//        
//    }
//    
//    @IBAction func domesticButtonClicked(_ sender: UIButton) {
//        var filter: [City] = []
//        
//        let cityDomestic = CityInfo().city
//        
//        for city in cityDomestic {
//            if city.domestic_travel == true {
//                filter.append(city)
//            }
//        }
//        city = filter
//        cityColletionView.reloadData()
//        
//    }
//    
//    
//    @IBAction func overseasButtonClicked(_ sender: UIButton) {
//        var filter: [City] = []
//        
//        let cityOverseas = CityInfo().city
//        
//        for city in cityOverseas {
//            if city.domestic_travel == false {
//                filter.append(city)
//            }
//        }
//        
//        city = filter
//        cityColletionView.reloadData()
//        
//    }
//    
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        var  filter1: [City] = []
        var  filter2: [City] = []
        var  filter3: [City] = []
        let cityResult = CityInfo().city

        for citySeg in cityResult {
            if segment.selectedSegmentIndex == 0 {
                filter1.append(citySeg)
                city = filter1
                print("0번", city)
            }
            else if segment.selectedSegmentIndex == 1 {
                if citySeg.domestic_travel == true {
                    filter2.append(citySeg)
                    city = filter2
                    print("1번", city)

                }

            }
            else if segment.selectedSegmentIndex == 2 {
                if citySeg.domestic_travel == false {
                    filter3.append(citySeg)
                    city = filter3
                    print("2번", city)
                }
            }
            
        }
        cityColletionView.reloadData()

        
    }
    
}

