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
        self.setImagePointSize(style.imagePointSize)
        self.titleLabel?.font = style.titleFont
        self.setTitleColor(style.titleColor, for: .normal)
        self.tintColor = style.tintColor
        self.backgroundColor = style.backgroundColor
    }
    
    func setImagePointSize(_ pointSize: CGFloat?) {
        guard let size = pointSize else { return }
        let imageConfig = UIImage.SymbolConfiguration(pointSize: size)
        
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = imageConfig
        self.configuration = config
    }
}

struct ButtonStyle {
    var title: String?
    var image: UIImage?
    var imagePointSize: CGFloat?
    var titleFont: UIFont
    var titleColor: UIColor
    var tintColor: UIColor
    var backgroundColor: UIColor
    
    static let `default` = ButtonStyle(
        title: "",
        image: nil,
        imagePointSize: 16,
        titleFont: .systemFont(ofSize: 13),
        titleColor: .black, 
        tintColor: .black,
        backgroundColor: .clear
    )
}
