//
//  UIButton+.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension UIButton {
    func setButton(style: ButtonStyle = .default) {
        self.setTitle(style.title, for: .normal)
        self.setImage(style.image, for: .normal)
        self.titleLabel?.font = style.titleFont
        self.setTitleColor(style.titleColor, for: .normal)
        self.tintColor = style.tintColor
        self.backgroundColor = style.backgroundColor
    }
}

struct ButtonStyle {
    var title: String?
    var image: UIImage?
    var titleFont: UIFont
    var titleColor: UIColor
    var tintColor: UIColor
    var backgroundColor: UIColor
    
    static let `default` = ButtonStyle(
        title: nil,
        image: nil,
        titleFont: .systemFont(ofSize: 13),
        titleColor: .black, 
        tintColor: .black,
        backgroundColor: .clear
    )
}
