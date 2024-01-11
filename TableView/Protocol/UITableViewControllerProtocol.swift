//
//  UITableViewControllerProtocol.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

protocol UITableViewControllerProtocol: UIViewController {
    func configureTableView()
    func registerXib()
    func connectDelegate()
}
