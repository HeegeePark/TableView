//
//  UICollectionViewCellProtocol.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

@objc
protocol UICollectionViewCellProtocol {
    // 정적인 디자인 셀 구성
    func configureUI()
    
    // 데이터 바인딩
    @objc optional func bindItem(data: Any)
}
