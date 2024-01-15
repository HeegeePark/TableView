//
//  ADTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/11/24.
//

import UIKit

class ADTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        cellView.setRandomBackgroundColor()
    }
}

extension ADTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        
        // 배경
        cellView.setRandomBackgroundColor()
        cellView.setCornerRadius()
        
        // 광고 내용
        var style = LabelStyle.default
        style.textAlignment = .center
        adLabel.setLabel(style: style)
        adLabel.setBold()
    }
    
    func bindItem(data: Any) {
        guard let travel = data as? Travel else { return }
        adLabel.text = travel.title
    }
}
