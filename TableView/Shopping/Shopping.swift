//
//  Shopping.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

struct Shopping: Codable {
    var title: String
    var isDone: Bool
    var isStarred: Bool
    
    static func getDummy() -> [Self] {
        return [Shopping(title: "그립톡 구매하기", isDone: true, isStarred: true),
                Shopping(title: "사이다 구매", isDone: false, isStarred: false),
                Shopping(title: "아이패드 케이스 최저가 알아보기", isDone: false, isStarred: true),
                Shopping(title: "양말", isDone: false, isStarred: true)]
    }
}

