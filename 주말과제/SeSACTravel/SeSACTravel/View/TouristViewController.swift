//
//  TouristViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/15/25.
//

import UIKit
import Kingfisher

class TouristViewController: UIViewController {

    
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    
    var travelImageData = ""
    var titleLabelData = ""
    var bodyData = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: travelImageData)

        travelImage.kf.setImage(with: url)
        titleLabel.text = titleLabelData
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        bodyLabel.text = bodyData
        bodyLabel.textAlignment = .center
        bodyLabel.font = .systemFont(ofSize: 15, weight: .bold)
        bodyLabel.numberOfLines = 0
        popButton.backgroundColor = .systemBlue
        popButton.setTitle("다른 관광지 보러 가기", for: .normal)
        popButton.layer.cornerRadius = 10
        popButton.setTitleColor(.white, for: .normal)
    }

    @IBAction func popButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
