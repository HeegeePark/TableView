//
//  TravelTableViewController.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

class MagazineTableViewController: UITableViewController {
    let list = MagazineInfo.magazine

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
}

// MARK: - Custom UI
extension MagazineTableViewController {
    func configureTableView() {
        tableView.rowHeight = 460
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableView
extension MagazineTableViewController {
    // 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // 셀 디자인 및 기능 로직
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let magazine = list[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath) as? MagazineTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bindItem(data: magazine)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
