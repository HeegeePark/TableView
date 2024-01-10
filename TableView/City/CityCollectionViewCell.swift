//
//  CityCollectionViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    static let identifier = "CityCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        // 이미지 뷰
        imageView.contentMode = .scaleToFill
        
        // 도시이름 레이블
        var titleStyle = LabelStyle.title
        titleStyle.textAlignment = .center
        nameLabel.setLabel(style: titleStyle)
        
        
        // 설명 레이블
        var subTitleStyle = LabelStyle.subtitle
        subTitleStyle.textAlignment = .center
        subTitleStyle.numberOfLines = 2
        explainLabel.setLabel(style: subTitleStyle)
    }
    
    func configureUI(city: City) {
        let url = URL(string: city.imageString)
        imageView.kf.setImage(with: url!)
        nameLabel.text = city.name + " | " + city.englishName
        explainLabel.text = city.explain
    }
    
    // TODO: Circle 이슈 해결할 수 있는 메서드, 공부해볼 것.
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
}
