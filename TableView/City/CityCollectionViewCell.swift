//
//  CityCollectionViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit
import RegexBuilder

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.setCornerRadius(style: .circle(imageView))
    }
}

extension CityCollectionViewCell: UICollectionViewCellProtocol {
    // 정적인 셀 디자인
    func configureUI() {
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
    
    // 데이터 바인딩
    func bindItem(data: Any) {
        guard let city = data as? City else { return }
        
        let url = URL(string: city.imageString)
        imageView.kf.setImage(with: url!)
        nameLabel.text = city.name + " | " + city.englishName
        explainLabel.text = city.explain
    }
    
    // 검색 키워드 글자 배경색 변경
    func changeColorBySearchKeyword(_ keyword: String?) {
        guard let keyword = keyword?.refineForSearch else { return }
        
        for label in [nameLabel, explainLabel] {
            label?.changeBackgroundColorBySearchKeyword(keyword: keyword, color: .yellow)
        }
    }
}
