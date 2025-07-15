//
//  TravelTableViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/13/25.
//

import UIKit
import Kingfisher
import Toast
class TravelTableViewController: UITableViewController {
    
    var travel: [Travel] {
        return TravelInfo.shared.travelList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        let xib = UINib(nibName: "Travel2TableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "Travel2TableViewCell")
        
        let xib2 = UINib(nibName: "adTableViewCell", bundle: nil)
        tableView.register(xib2, forCellReuseIdentifier: "adTableViewCell")
//
    }
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Travel2TableViewCell", for: indexPath) as! Travel2TableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "adTableViewCell", for: indexPath) as! adTableViewCell
        let trabelIndexPath = travel[indexPath.row]
        
        if trabelIndexPath.ad == false {
            cell.configureTravelUI(trabelIndexPath: trabelIndexPath)
            
            cell.likeButton.tag = indexPath.row
            if trabelIndexPath.like == true {
                cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
            }
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            return cell
        }
        else {
            cell2.configureAdUI()
            cell2.backgroundColor = .systemPink
            return cell2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        TravelInfo.shared.travelList[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    //셀 클릭 이벤트
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trabelIndexPath = travel[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)

        if trabelIndexPath.ad == false {
            let vc = sb.instantiateViewController(withIdentifier: "TouristViewController") as! TouristViewController
            vc.travelImageData = trabelIndexPath.travel_image ?? ""
            vc.titleLabelData = trabelIndexPath.title ?? ""
            vc.bodyData = trabelIndexPath.description ?? ""
            navigationController?.pushViewController(vc, animated: true)
            print(vc.travelImageData)
            print("클릭")
        }
        else {
            let vc = sb.instantiateViewController(withIdentifier: "AdViewController") as! AdViewController
            vc.ad = trabelIndexPath.title ?? ""
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            print("클릭")

        }
        if trabelIndexPath.ad == true {
            view.makeToast("광고 셀입니다!", duration: 5, position: .center)
            tableView.reloadData()
        }
        
    }
    
}
