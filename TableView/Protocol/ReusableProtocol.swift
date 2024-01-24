//
//  Reusable.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import Foundation

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
