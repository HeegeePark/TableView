//
//  String+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension String {
    func toDate() -> Date? {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyMMdd"
        
        return dateFomatter.date(from: self)
    }
}
