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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }
}

// MARK: - Custom UI
extension TravelTalkViewController: CustomViewControllerProtocol, UITableViewControllerProtocol {
    func setupUI() {}
    
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
        return ChatRoom.mockChatList.count
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
