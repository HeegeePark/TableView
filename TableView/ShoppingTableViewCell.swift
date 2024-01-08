//
//  TodoTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/6/24.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var starButton: UIButton!
    
    static let identifier = "ShoppingTableViewCell"
    
    func setupUI(shopping: Shopping) {
        // 셀 백그라운드 뷰
        cellView.backgroundColor = #colorLiteral(red: 0.951883018, green: 0.9470081925, blue: 0.9709880948, alpha: 1)
        cellView.layer.cornerRadius = 8
        
        // 타이틀 레이블
        label.text = shopping.title
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        
        // 체크 버튼
        let checkImage = shopping.isDone ? UIImage(systemName: "checkmark.square.fill"): UIImage(systemName: "checkmark.square")
        checkButton.setImage(checkImage, for: .normal)
        checkButton.tintColor = .black
        
        // 별 버튼
        let starImage = shopping.isStarred ? UIImage(systemName: "star.fill"): UIImage(systemName: "star")
        starButton.setImage(starImage, for: .normal)
        starButton.tintColor = .black
    }
    
}
