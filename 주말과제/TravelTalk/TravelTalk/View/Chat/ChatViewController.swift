//
//  ChatViewController.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let chatList = ChatList.list
     
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "ChattingRoomTableViewCell", bundle: nil)
        chatTableView.register(xib, forCellReuseIdentifier: "ChattingRoomTableViewCell")
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = .none //선없애기
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingRoomTableViewCell", for: indexPath) as! ChattingRoomTableViewCell
        cell.configureData(chatList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChattingRoomViewController") as! ChattingRoomViewController
        vc.chatData = chatList[indexPath.row]
        vc.userRemove = chatList[indexPath.row].chatList.last?.user.name ?? ""
        print(chatList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        
    }

    
}
