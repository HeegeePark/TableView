//
//  UILabel+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension UILabel {
    // Label 스타일 설정
    func setLabel(style: LabelStyle = .default) {
        self.font = style.font
        self.textColor = style.textColor
        self.textAlignment = style.textAlignment
        self.numberOfLines = style.numberOfLines
    }
    
    // 날짜 포맷: String -> Date -> String
    func setDateText(data: String) {
        self.text = data.toDate()?.toString()
    }
}

struct LabelStyle {
    var font: UIFont
    var textColor: UIColor
    var textAlignment: NSTextAlignment = .left
    var numberOfLines: Int
    
    static let `default` = LabelStyle(
                            font: .systemFont(ofSize: 16),
                            textColor: .black,
                            textAlignment: .left,
                            numberOfLines: 0
                        )
    
    static let title = LabelStyle(
                            font: .boldSystemFont(ofSize: 18),
                            textColor: .black,
                            textAlignment: .left,
                            numberOfLines: 0
                        )
    
    static let subtitle = LabelStyle(
                            font: .boldSystemFont(ofSize: 14)
,
                            textColor: .gray,
                            textAlignment: .left,
                            numberOfLines: 2
                        )
    
    static let date = LabelStyle(
                            font: .boldSystemFont(ofSize: 12),
                            textColor: .gray,
                            textAlignment: .left,
                            numberOfLines: 1
                        )
}
