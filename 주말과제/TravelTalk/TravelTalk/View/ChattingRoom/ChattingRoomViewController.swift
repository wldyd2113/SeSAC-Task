//
//  ChattingRoomViewController.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class ChattingRoomViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var chatRoomTable: UITableView!
    
    var chatData = ChatRoom(chatroomId: 0, chatroomImage: "", chatroomName: "")
    var filterUser:[Chat] = []
    var userRemove = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(chatData.chatroomName)"
        
        let xib = UINib(nibName: "OtherUserTableViewCell", bundle: nil)
        chatRoomTable.register(xib, forCellReuseIdentifier: "OtherUserTableViewCell")
        
        chatRoomTable.separatorStyle = .none
        
        chatRoomTable.delegate = self
        chatRoomTable.dataSource = self
        
        for i in chatData.chatList {
            if i.user.name != userRemove {
                filterUser.append(i)
            }
            
        }


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserTableViewCell", for: indexPath) as! OtherUserTableViewCell
        let chat = chatData.chatList[indexPath.row]
        
        
        cell.configureData(chat)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}
