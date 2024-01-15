//
//  TravelTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailImageView.setCornerRadius(style: .medium)
    }
}

extension MagazineTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        // 썸네일 이미지 뷰
        thumbnailImageView.contentMode = .scaleAspectFill
        
        // 제목 레이블
        titleLabel.setLabel(style: .title)
        titleLabel.lineBreakMode = .byWordWrapping
        
        // 부제 레이블
        subtitleLabel.setLabel(style: .subtitle)
        
        // 날짜 레이블
        dateLabel.setLabel(style: .date)
    }
    
    func bindItem(data: Any) {
        guard let magazine = data as? Magazine else { return }
        
        // 썸네일 이미지 뷰
        let url = URL(string: magazine.photo_image)
        thumbnailImageView.kf.setImage(with: url)
        
        // 제목 레이블
        titleLabel.text = magazine.title
        
        // 부제 레이블
        subtitleLabel.text = magazine.subtitle
        
        // 날짜 레이블
        dateLabel.setDateText(data: magazine.date)
    }
}
