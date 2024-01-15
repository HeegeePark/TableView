//
//  SpotTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/11/24.
//

import UIKit

class SpotTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var starImageView: [UIImageView]!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }
}

extension SpotTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        // 제목
        titleLabel.setLabel(style: .title)
        
        // 부제
        descriptionLabel.setLabel(style: .subtitle)
        
        // 포스터
        posterImageView.setCornerRadius()
        posterImageView.contentMode = .scaleAspectFill
        
        // 별점 이미지뷰
        for star in starImageView {
            star.tintColor = #colorLiteral(red: 1, green: 0.8604621291, blue: 0.0521453768, alpha: 1)
        }
        
        // 저장 수 레이블
        saveLabel.setLabel(style: .date)
    }
    
    func bindItem(data: Any) {
        guard let travel = data as? Travel else { return }
        
        titleLabel.text = travel.title
        
        descriptionLabel.text = travel.description
        
        let url = URL(string: travel.travel_image!)
        posterImageView.kf.setImage(with: url)
        
        setStarImage(grade: travel.grade!)
        
        saveLabel.text = "• 저장 \(travel.save!.setComma())"
        
        var style = ButtonStyle.default
        style.image = !travel.like! ? UIImage(systemName: "heart"): UIImage(systemName: "heart.fill")
        style.tintColor = .white
        likeButton.setButton(style: style)
    }
    
    func setStarImage(grade: Double) {
        var starCount = Int(grade)
        let isExistHalfStar = grade - Double(starCount) > 0.5
        
        for star in starImageView[0..<starCount] {
            star.image = UIImage(systemName: "star.fill")
        }
        
        for star in starImageView[starCount...] {
            star.image = UIImage(systemName: "star")
        }
        
        if isExistHalfStar {
            starImageView[starCount].image = UIImage(systemName: "star.leadinghalf.filled")
        }
    }
}
