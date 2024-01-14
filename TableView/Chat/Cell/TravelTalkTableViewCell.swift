//
//  TravelTalkTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

class TravelTalkTableViewCell: UITableViewCell {
    static let identifier = "TravelTalkTableViewCell"

    @IBOutlet var profileImageIView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var recentChatLabel: UILabel!
    @IBOutlet var recentChatDateLael: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageIView.setCornerRadius(style: .circle(profileImageIView))
    }
}

extension TravelTalkTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        // 이미지 레이블
        profileImageIView.contentMode = .scaleAspectFill
        profileImageIView.backgroundColor = .red
        
        // 닉네임 레이블
        nicknameLabel.setLabel(style: .title)
        
        // 최근 채팅 레이블
        recentChatLabel.setLabel(style: .subtitle)
        
        // 최근 채팅 날짜 레이블
        recentChatDateLael.setLabel(style: .date)
    }
}
