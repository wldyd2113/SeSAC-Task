//
//  TravelTableViewswift
//  SeSACTravel
//
//  Created by 차지용 on 7/13/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dscriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var textsLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var trabelImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var ratingImage: [UIImageView]!
    
    @IBOutlet var adUIView: UIView!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var adButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
        
        dscriptionLabel.numberOfLines = 0
        
        gradeLabel.textColor = .lightGray
        gradeLabel.font = .systemFont(ofSize: 15)
        
        textsLabel.text = "저장"
        textsLabel.textColor = .lightGray
        textsLabel.font = .systemFont(ofSize: 15)
        
        saveLabel.textColor = .lightGray
        saveLabel.font = .systemFont(ofSize: 15)
    }
    
    func configureTravelUI(trabelIndexPath: Travel) {
        let url = URL(string: trabelIndexPath.travel_image ?? "person")
        
        
        titleLabel.text = trabelIndexPath.title
        
        dscriptionLabel.text = trabelIndexPath.description
        
        gradeLabel.text = String(trabelIndexPath.grade ?? 0)
        
        if let grade = trabelIndexPath.grade {
            let gradeInt = Int(grade)
            
            for (index, imageView) in ratingImage.enumerated() {
                if index < gradeInt {
                    imageView.image = UIImage(systemName: "star.fill")
                }
                else {
                    imageView.image = UIImage(systemName: "star")
                }
            }
        } else {
            for imageView in ratingImage {
                imageView.image = UIImage(systemName: "star")
            }
        }
        trabelImage.kf.setImage(with: url)
        
        if let numberString = trabelIndexPath.save {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            saveLabel.text = numberFormatter.string(from: NSNumber(value: numberString))
        } else {
            saveLabel.text = "0"
        }
        
        if trabelIndexPath.ad == true  {
            adUIView.backgroundColor = .systemPink
            adUIView.layer.cornerRadius = 10
            
            adLabel.text = "하와이 여행을 가고 싶다면? \n 수업이 있는데 가실 생각은 아니시죠?"
            adLabel.numberOfLines = 0
            adLabel.font = .systemFont(ofSize: 15, weight: .bold)
            adLabel.textAlignment = .center
            adButton.setTitle("AD", for: .normal)
            
        }
        else {
            adUIView.backgroundColor = .clear
            adLabel.text = ""
            adLabel.textAlignment = .center
            adButton.setTitle(" ", for: .normal)
        }
    }
}
