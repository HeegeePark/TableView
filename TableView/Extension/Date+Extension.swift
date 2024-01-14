//
//  Date+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension Date {
    func toString(format: String = "yy년 MM월 dd일", locale: String = "ko_KR") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: self)
    }
}
