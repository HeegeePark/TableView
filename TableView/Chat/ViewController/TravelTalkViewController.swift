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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as? TravelTalkTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
