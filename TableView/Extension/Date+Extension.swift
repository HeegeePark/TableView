//
//  Date+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        return dateFormatter.string(from: self)
    }
}
