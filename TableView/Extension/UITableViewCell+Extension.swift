//
//  UITableViewCell+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import UIKit

extension UITableViewCell: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
