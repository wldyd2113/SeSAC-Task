//
//  CityViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/16/25.
//

import UIKit

class CityViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    var cityList = CityInfo().city
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var cityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTable.delegate = self
        cityTable.dataSource = self
        let xib = UINib(nibName: "CityTableViewCell", bundle: nil)
        cityTable.register(xib, forCellReuseIdentifier: "CityTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count1: [City] = []
        for city in cityList {
            if segment.selectedSegmentIndex == 0 {
                count1.append(city)
            }
            else if segment.selectedSegmentIndex == 1 && city.domestic_travel == true {
                count1.append(city)
            }
            
            else if segment.selectedSegmentIndex == 2 && city.domestic_travel == false {
                count1.append(city)
            }
            
        }
        return count1.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        let cityIndexPath = cityList[indexPath.row]
        var cityTrue: [City] = []
        var cityFalse: [City] = []
        let selected = segment.selectedSegmentIndex
        
//        for city in cityList {
//            if city.domestic_travel == true {
//                cityTrue.append(city)
//                print("TrueSSS",cityTrue)
//            }
//        }
        //ex 다낭이 들어왔을때 분기처리
        if selected == 0 {
            cell.configureCityCell(cityIndexPath: cityIndexPath)
        }
        else if selected == 1  {
            if cityIndexPath.domestic_travel == true {
                print("sadasd",cityIndexPath)
                cell.configureCityCell(cityIndexPath: cityIndexPath)
                
            }
            else {
                cityFalse = cityList
            }
        }
        else if selected == 2   {
            if cityIndexPath.domestic_travel == false {
                cell.configureCityCell(cityIndexPath: cityIndexPath)
                print(cityTrue)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityData = cityList[indexPath.row]
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CityDetailViewController") as! CityDetailViewController
        vc.listData = cityData
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) { //필터된 데이터를 가지고 있게
        cityTable.reloadData()
    }
    
    
    @IBAction func serachText(_ sender: UITextField) {
    }
}
