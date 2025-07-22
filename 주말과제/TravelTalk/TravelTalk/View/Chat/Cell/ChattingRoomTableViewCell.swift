//
//  ChattingRoomTableViewCell.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class ChattingRoomTableViewCell: UITableViewCell, CellProtocol {
    

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = true
        
        userName.font = .boldSystemFont(ofSize: 15)
        
        messageLabel.font = .systemFont(ofSize: 10)
        messageLabel.textColor = .lightGray
        
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 10)

    }
    func configureData(_ chatData: ChatRoom) {

        
        guard let chat = chatData.chatList.last else { return }
        
        userImage.image = UIImage(named: chat.user.image)
        
        userName.text = chat.user.name
        
        messageLabel.text = chat.message

        let firstDate = DateFormatter()
        firstDate.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        
        let dateString = chat.date
        
        if let date = firstDate.date(from: dateString) {
            dateLabel.text = dateFormatter.string(for: date)
            print("형변환 성공")
        }
        else {
            print("형변환 실패")
        }

    }
    
    
}
