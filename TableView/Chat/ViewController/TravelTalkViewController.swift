//
//  TravelTalkViewController.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

class TravelTalkViewController: UIViewController {

    @IBOutlet var userSearchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var chatRoomList: [ChatRoom] = ChatRoom.mockChatList {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - Custom UI
extension TravelTalkViewController: CustomViewControllerProtocol, UITableViewControllerProtocol {
    func setupUI() {
        cofigureSearchBar()
        configureNavigationBar()
        configureTableView()
    }
    
    func cofigureSearchBar() {
        userSearchBar.placeholder = "친구 이름을 검색해보세요"
        userSearchBar.delegate = self
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Travel Talk"
    }
    
    func configureTableView() {
        registerXib()
        connectDelegate()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func registerXib() {
        let xib = UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
    }
    
    func connectDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as? TravelTalkTableViewCell else {
            return UITableViewCell()
        }
        
        let chatRoom = ChatRoom.mockChatList[indexPath.row]
        
        cell.bindItem(data: chatRoom)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoom = ChatRoom.mockChatList[indexPath.row]
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: ChatViewController.identifier) as? ChatViewController else {
            return
        }
        
        viewController.updateData(data: chatRoom)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension TravelTalkViewController: UISearchBarDelegate {
    // 텍스트가 바뀔 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // text empty 바인딩
        guard !searchText.isEmpty else {
            chatRoomList = ChatRoom.mockChatList
            return
        }
        
        // 띄어쓰기 막기
        guard !searchText.contains(" ") else {
            searchBar.text = searchText.replacingOccurrences(of: " ", with: "")
            return
        }
        
        // 대소문자 제거
        let lowercasedText = searchText.lowercased()
        
        // list 셋업
        chatRoomList = chatRoomList.filter { chatRoom in
            return chatRoom.userList.joined().lowercased().contains(lowercasedText)
        }
    }
    
    // search 버튼 클릭 시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
