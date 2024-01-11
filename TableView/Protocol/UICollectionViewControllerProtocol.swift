//
//  UICollectionViewControllerProtocol.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

protocol UICollectionViewControllerProtocol: UIViewController {
    func configureCollectionView()
    func registerXib()
    func connectDelegate()
    func configureLayout()
}

