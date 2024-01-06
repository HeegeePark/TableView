//
//  SettingTableViewController.swift
//  TableView
//
//  Created by 박희지 on 1/5/24.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    enum SettingCellItem: CaseIterable {
        case all
        case personal
        case etc
        
        var sectionTitle: String {
            switch self {
            case .all:
                return "전체 설정"
            case .personal:
                return "개인 설정"
            case .etc:
                return "기타"
            }
        }
        
        var cellTitle: [String] {
            switch self {
            case .all:
                return ["공지사항", "실험실", "버전 정보"]
            case .personal:
                return ["개인/보안", "알림", "채팅", "멀티프로필"]
            case .etc:
                return ["고객센터/도움말"]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableView
    // section 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingCellItem.allCases.count
    }
    
    // section별 cell 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCellItem.allCases[section].cellTitle.count
    }
    
    // cell 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath)
        
        let settingType = SettingCellItem.allCases[indexPath.section]
        cell.textLabel?.text = settingType.cellTitle[indexPath.row]
        
        return cell
    }
    
    // cell 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // section header title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingCellItem.allCases[section].sectionTitle
    }
}
