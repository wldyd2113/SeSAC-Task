//
//  CityViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/16/25.
//

import UIKit

class CityViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    let cityList = CityInfo().city
    
    @IBOutlet var searchTextField: UISearchBar!
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
        
        return cityList.count
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
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
    }
}
