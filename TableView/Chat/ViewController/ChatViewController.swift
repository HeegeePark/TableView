//
//  ChatViewController.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

class ChatViewController: UIViewController {
    static let identifier = "ChatViewController"
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var inputAreaView: UIView!
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var inputTextButton: UIButton!
    
    
    var chatRoom: ChatRoom?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureNavigationBar()
        configureTableView()
    }
    
    func updateData(data: ChatRoom) {
        self.chatRoom = data
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - Custom UI
extension ChatViewController: CustomViewControllerProtocol, UITableViewControllerProtocol {
    func setupUI() {
        // TODO: 채팅 텍스트뷰
        inputAreaView.backgroundColor = .black
    }
    
    func configureNavigationBar() {
        navigationItem.title = chatRoom?.chatroomName
        
        let leftButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.left"), target: self, action: #selector(popButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func configureTableView() {
        registerXib()
        connectDelegate()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func registerXib() {
        let xib1 = UINib(nibName: ChatReceiverTableViewCell.identifier, bundle: nil)
        tableView.register(xib1, forCellReuseIdentifier: ChatReceiverTableViewCell.identifier)
        
        let xib2 = UINib(nibName: ChatUserTableViewCell.identifier, bundle: nil)
        tableView.register(xib2, forCellReuseIdentifier: ChatUserTableViewCell.identifier)
    }
    
    func connectDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatRoom!.chatList[indexPath.row]
        
        if chat.isUserChat {   // 유저
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatUserTableViewCell.identifier) as? ChatUserTableViewCell else {
                return UITableViewCell()
            }
            
            cell.bindItem(data: chat)
            cell.selectionStyle = .none
            
            return cell
        } else {    // 수신자
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatReceiverTableViewCell.identifier) as? ChatReceiverTableViewCell else {
                return UITableViewCell()
            }
            
            cell.bindItem(data: chat)
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
