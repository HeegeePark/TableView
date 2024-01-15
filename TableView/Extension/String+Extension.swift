//
//  String+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/10/24.
//

import UIKit

extension String {
    // String -> Date
    func toDate(format: String = "yyMMdd") -> Date? {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = format
        
        return dateFomatter.date(from: self)
    }
    
    // whitespace 처리
    var removeWhitespace: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    // whitespace & 소문자화
    var refineForSearch: String {
        return self.removeWhitespace.lowercased()
    }
}
