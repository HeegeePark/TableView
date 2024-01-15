//
//  Magazine.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

struct Magazine {
    let title : String
    let subtitle: String
    let photo_image: String
    let date: String
    let link: String
    
    var linkURL: URL {
        return URL(string: link)!
    }
}
