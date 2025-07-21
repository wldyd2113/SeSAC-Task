//
//  ChattingRoomViewController.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class ChattingRoomViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var chatRoomTable: UITableView!
    @IBOutlet var messageTextField: UITextField!
    
    var chatData = ChatRoom(chatroomId: 0, chatroomImage: "", chatroomName: "")
    var userRemove = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(chatData.chatroomName)"
        
        let xib = UINib(nibName: "OtherUserTableViewCell", bundle: nil)
        chatRoomTable.register(xib, forCellReuseIdentifier: "OtherUserTableViewCell")
        
        let xib2 = UINib(nibName: "UserTableViewCell", bundle: nil)
        chatRoomTable.register(xib2, forCellReuseIdentifier: "UserTableViewCell")
        
        chatRoomTable.separatorStyle = .none
        
        chatRoomTable.delegate = self
        chatRoomTable.dataSource = self
        
        textFieldUI()

    }
    
    private func textFieldUI() {
        messageTextField.placeholder = "메세지를 입력해주세요"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = chatData.chatList[indexPath.row]
        let meName = "김새싹"
        var meBool: Bool {
            for chat in chatData.chatList {
                if chat.user.name == meName {
                    return true
                }
            }
            return false
        }
        if meBool {
            if chat.user.name == userRemove {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserTableViewCell", for: indexPath) as! OtherUserTableViewCell
                cell.configureData(chat)
                return cell
            }
            else  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
                cell.configureUserData(chat)
                return cell
            }
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserTableViewCell", for: indexPath) as! OtherUserTableViewCell
            cell.configureData(chat)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}

/*
 1. 값전달 코드 지우고 다시 전달해보기
 2. 텍스트 필드 검색 (1. 풀네임검색 2. 부분문자열로 검색) + 키보드 내리기
 3. 채팅에서 채팅보내면 tableview 리로드
 4. 오토디멘션 사용해서 셀높이 유동적으로 조절되게 해보기
 */
