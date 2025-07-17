//
//  CityViewController.swift
//  CityColletoion
//
//  Created by 차지용 on 7/17/25.
//

import UIKit
import Kingfisher

class CityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    let city = CityInfo().city
    @IBOutlet var cityColletionView: UICollectionView!
    
    @IBOutlet var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityColletionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        cityColletionView.delegate = self
        cityColletionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let devieWith = UIScreen.main.bounds.width
        let cellWidth = devieWith - (20 * 3) - (20 * 2)
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return city.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cityList = city[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as! CityCollectionViewCell
        cell.configureCell(cityIndexPath: cityList)
        return cell
    }

}
