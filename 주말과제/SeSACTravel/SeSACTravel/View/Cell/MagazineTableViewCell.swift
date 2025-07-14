//
//  TravelTableViewCell.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/11/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {

    @IBOutlet var potoImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 10, weight: .light)
        subtitleLabel.textColor = .lightGray
        
    }
    
    func configureUI(mazinageRow: Magazine) {
        let url = URL(string: mazinageRow.photo_image)
       
        
        let firstDateformatter = DateFormatter()
        firstDateformatter.dateFormat = "yyMMdd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        
        let dateString = mazinageRow.date
        titleLabel.text = mazinageRow.title
        subtitleLabel.text = mazinageRow.subtitle
        potoImage.kf.setImage(with: url)
        potoImage.layer.cornerRadius = 10
        
        if let date = firstDateformatter.date(from: dateString) {
            dateLabel.text = dateFormatter.string(for: date)
            print("변환된 날짜: \(date))")
        }
        else {
            print("날짜 변환 실패")
        }
        dateLabel.font = .systemFont(ofSize: 10, weight: .light)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        print(dateLabel.text ?? 0)
        
    }

}
