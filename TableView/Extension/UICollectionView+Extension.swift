//
//  UICollectionView.swift
//  TableView
//
//  Created by 박희지 on 1/11/24.
//

import UIKit


extension UICollectionView {
    // 컬렌션뷰 레이아웃 설정
    func setLayout(inset: CGFloat, spacing: CGFloat, ratio: CGFloat, colCount: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (spacing + 2 * inset)) / colCount
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * ratio)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionViewLayout = layout
    }
}
