//
//  CityDetailViewController.swift
//  TableView
//
//  Created by 박희지 on 1/11/24.
//

import UIKit

enum CellType: CaseIterable {
    case spot
    case ad
    
    var cellReuseIdentifier: String  {
        switch self {
        case .spot:
            return SpotTableViewCell.identifier
        case .ad:
            return ADTableViewCell.identifier
        }
    }
    
    // TODO: 제네릭으로 Cell 타입 반환해보기
}

class CityDetailViewController: UIViewController {
    static let identifier = "CityDetailViewController"

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }    
}

// MARK: - Custom UI

extension CityDetailViewController {
    func configureNavigationBar() {
        navigationItem.title = "도시 상세 정보"
    }
    
    func configureTableView() {
        registerXib()
        connectDelegate()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerXib() {
        for cell in CellType.allCases {
            let xib = UINib(nibName: cell.cellReuseIdentifier, bundle: nil)
            tableView.register(xib, forCellReuseIdentifier: cell.cellReuseIdentifier)
        }
    }
    
    func connectDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CityDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Travel.dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = Travel.dummy[indexPath.row]
        let cellType: CellType = !travel.ad ? .spot: .ad
        
        switch cellType {
        case .spot:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellReuseIdentifier, for: indexPath) as? SpotTableViewCell else { return UITableViewCell() }
            
            cell.bindItem(data: travel)
            return cell
        case .ad:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellReuseIdentifier, for: indexPath) as? ADTableViewCell else { return UITableViewCell() }
            
            cell.bindItem(data: travel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = Travel.dummy[indexPath.row]
        let cellType: CellType = !travel.ad ? .spot: .ad
        
        switch cellType {
        case .spot:
            guard let viewController = self.storyboard?.instantiateViewController(identifier: SpotViewController.identifier) else { return }
            navigationController?.pushViewController(viewController, animated: true)
        case .ad:
            guard let viewController = self.storyboard?.instantiateViewController(identifier: ADViewController.identifier) else { return }
            let navigationVC = UINavigationController(rootViewController: viewController)
            navigationVC.modalPresentationStyle = .fullScreen
            present(navigationVC, animated: true)
        }
    }
}
