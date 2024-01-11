//
//  CustomViewControllerProtocol.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

@objc
protocol CustomViewControllerProtocol: AnyObject {
    func setupUI()
    @objc optional func configureNavigationBar()
}
