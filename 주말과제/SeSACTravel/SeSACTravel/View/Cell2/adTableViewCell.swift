//
//  adTableViewCell.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/15/25.
//

import UIKit

class adTableViewCell: UITableViewCell {
    
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var adButton: UIButton!
    
    func configureAdUI() {
        adLabel.backgroundColor = .systemPink
        adLabel.text = "하와이 여행을 가고 싶다면? \n 수업이 있는데 가실 생각은 아니시죠?"
        adLabel.numberOfLines = 0
        adLabel.font = .systemFont(ofSize: 15, weight: .bold)
        adLabel.textAlignment = .center
        adButton.setTitle("AD", for: .normal)
    }
    
}
