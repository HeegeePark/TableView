//
//  ChatTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

class ChatReceiverTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var bubbleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.setCornerRadius(style: .circle(profileImageView))
    }
    
    override func prepareForReuse() {
        clearData()
    }
}

extension ChatReceiverTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        // 프로필 이미지 뷰
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .white
        profileImageView.layer.borderWidth = 0.2
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        
        // 닉네임 레이블
        nicknameLabel.setLabel()
        nicknameLabel.setBold()
        nicknameLabel.numberOfLines = 1
        
        // 수신 메시지
        bubbleLabel.setLabel()
        bubbleLabel.numberOfLines = 0
        bubbleLabel.setCornerRadius()
        bubbleLabel.layer.borderWidth = 0.2
        bubbleLabel.layer.borderColor = UIColor.gray.cgColor
        
        // 날짜
        dateLabel.setLabel(style: .date)
    }
    
    func bindItem(data: Any) {
        guard let chat = data as? Chat else { return }
        
        // 프로필 이미지 뷰
        profileImageView.image = chat.profileImage
        
        // 닉네임 레이블
        nicknameLabel.text = chat.userName
        
        // 수신 메시지
        bubbleLabel.text = chat.message
        
        // 날짜
        dateLabel.text = chat.dateFormattedString
    }
    
    func clearData() {
        profileImageView.image = nil
        nicknameLabel.text = nil
        bubbleLabel.text = nil
        dateLabel.text = nil
    }
}
