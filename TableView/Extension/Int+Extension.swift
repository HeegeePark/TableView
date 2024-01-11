//
//  Int+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import Foundation

extension Int {
    // 숫자 포맷: 세자리수 콤마
    func setComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: self) ?? "0"
    }
}
