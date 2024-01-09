//
//  TravelTableViewController.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

class TravelTableViewController: UITableViewController {
    let list = Magazine.getDummy()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 460
        tableView.separatorStyle = .none
    }

    // 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // 셀 디자인 및 기능 로직
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let magazine = list[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupUI(magazine: magazine)
        
        return cell
    }
}
