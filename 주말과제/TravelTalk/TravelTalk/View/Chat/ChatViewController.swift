//
//  ChatViewController.swift
//  TravelTalk
//
//  Created by 차지용 on 7/19/25.
//

import UIKit

class ChatViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource  {

    
    
    let chat = ChatList.list
    var filterChat: [ChatRoom] = []
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var chatColletionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterChat = chat
        
        let xib = UINib(nibName: "ChatttingRoomCollectionViewCell", bundle: nil)
        chatColletionView.register(xib, forCellWithReuseIdentifier: "ChatttingRoomCollectionViewCell")
        
        chatColletionView.delegate = self
        chatColletionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let devieWith = UIScreen.main.bounds.width
        let cellWidth = devieWith

        layout.itemSize = CGSize(width: cellWidth, height: 120) // 또는 적절한 높이 (예: 120)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8 //
        layout.minimumInteritemSpacing = 8 //셀사이의 간격
        layout.scrollDirection = .vertical
        chatColletionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterChat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatttingRoomCollectionViewCell", for: indexPath) as! ChatttingRoomCollectionViewCell
        cell.configureData(filterChat[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChattingRoomViewController") as! ChattingRoomViewController
        vc.chatData = filterChat[indexPath.row]
        vc.userRemove = filterChat[indexPath.row].chatList.last?.user.name ?? ""
        print(filterChat[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    


    @IBAction func searchText(_ sender: UITextField) {
        guard let search = sender.text, !search.isEmpty else {
            filterChat = chat
            chatColletionView.reloadData()
            return
        }
        filterChat = chat.filter { $0.chatList.last?.user.name.contains(search) ?? false}
        chatColletionView.reloadData()
        
    }
    
}
