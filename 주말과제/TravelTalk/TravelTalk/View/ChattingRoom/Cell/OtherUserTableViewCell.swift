//
//  OtherUserTableViewCell.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class OtherUserTableViewCell: UITableViewCell {
    
    static let identifier = "OtherUserTableViewCell"
    
    @IBOutlet var chatroomImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var messageView: UIView!
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        chatroomImage.layer.cornerRadius = chatroomImage.layer.frame.height / 2
        chatroomImage.layer.masksToBounds = true
        
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 10)
        nameLabel.numberOfLines = 0
        
        messageView.backgroundColor = .white
        messageView.layer.cornerRadius = 10
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        
        messageLabel.textColor = .black
        messageLabel.font = .systemFont(ofSize: 10)
        messageLabel.numberOfLines = 0
        
        
        dateLabel.font = .systemFont(ofSize: 5)
        dateLabel.textColor = .lightGray
        
    }
    
    func configureData(_ chat: Chat) {
        chatroomImage.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        print(nameLabel.text)
        messageLabel.text = chat.message
        
        let dateString = chat.date
        
        if let date = UserTableViewCell.firstDateExtension.date(from: dateString) {
            dateLabel.text = UserTableViewCell.dateFormatterExtension.string(for: date)
            print("형변환 성공")
        }
        else {
            print("형변환 실패")
        }

    }

}
