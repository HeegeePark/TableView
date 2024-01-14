//
//  String+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension String {
    func toDate(format: String = "yyMMdd") -> Date? {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = format
        
        return dateFomatter.date(from: self)
    }
}
