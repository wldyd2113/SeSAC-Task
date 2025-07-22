//
//  UserTableViewCell.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class UserTableViewCell: UITableViewCell, CellProtocol {
    
    static let identifier = "UserTableViewCell"
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var messageView: UIView!
    @IBOutlet var userMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        messageView.backgroundColor = .white
        messageView.layer.cornerRadius = 10
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        
        userMessage.numberOfLines = 0
        userMessage.textColor = .black
        userMessage.font = .systemFont(ofSize: 10)
        
        dateLabel.font = .systemFont(ofSize: 5)
        dateLabel.textColor = .lightGray
        
    }
    func configureData(_ chat: Chat) {
        userMessage.text = chat.message
        
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
