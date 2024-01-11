//
//  UIView+.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import Foundation

import UIKit

extension UIView {
    func setCornerRadius(style: CornerRoundStyle = .default) {
        self.layer.cornerRadius = style.cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setRandomBackgroundColor() {
        self.backgroundColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 0.5
        )
    }
}

enum CornerRoundStyle {
    case `default`
    case small
    case medium
    case large
    case circle(UIView)
    
    var cornerRadius: CGFloat {
        switch self {
        case .default:
            return 10
        case .small:
            return 8
        case .medium:
            return 16
        case .large:
            return 20
        case .circle(let view):
            return view.frame.width / 2
        }
    }
}
