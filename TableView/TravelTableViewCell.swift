//
//  TravelTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit
import Kingfisher

class TravelTableViewCell: UITableViewCell {
    static let identifier = "TravelTableViewCell"

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func setupUI(magazine: Magazine) {
        // 썸네일 이미지 뷰
        let url = URL(string: magazine.photo_image)
        thumbnailImageView.kf.setImage(with: url)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 16
        
        // 제목 레이블
        titleLabel.text = magazine.title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        
        // 부제 레이블
        subtitleLabel.text = magazine.subtitle
        subtitleLabel.font = .boldSystemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 1
        
        // 부제 레이블
        dateLabel.text = dateFormatting(magazine.date)
        dateLabel.font = .boldSystemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.numberOfLines = 1
    }
    
    // 날짜 포맷: String -> Date -> String
    func dateFormatting(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "날짜 불러오기 실패"
        }
        
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
}
