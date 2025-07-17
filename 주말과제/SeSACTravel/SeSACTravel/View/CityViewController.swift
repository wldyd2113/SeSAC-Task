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
        
        
        cell.configureCityCell(cityIndexPath: cityIndexPath)
        
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
        var  filter1: [City] = []
        var  filter2: [City] = []
        var  filter3: [City] = []
        let cityResult = CityInfo().city
        
        for citySeg in cityResult {
            if segment.selectedSegmentIndex == 0 {
                filter1.append(citySeg)
                cityList = filter1
                print("0번", cityList)
                
            }
            else if segment.selectedSegmentIndex == 1 {
                if citySeg.domestic_travel == true {
                    filter2.append(citySeg)
                    cityList = filter2
                    print("1번", cityList)
                    
                }
                
            }
            else if segment.selectedSegmentIndex == 2 {
                if citySeg.domestic_travel == false {
                    filter3.append(citySeg)
                    cityList = filter3
                    print("2번", cityList)
                }
            }
            
        }
        cityTable.reloadData()
        
    }
    
    
    @IBAction func serachText(_ sender: UITextField) {
    }
}
