//
//  TravelTalkTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

class TravelTalkTableViewCell: UITableViewCell {
    static let identifier = "TravelTalkTableViewCell"

    @IBOutlet var profileView: UIView!
    @IBOutlet var oneProfileImageView: [UIImageView]!
    @IBOutlet var twoProfileImageView: [UIImageView]!
    @IBOutlet var threeProfileImageView: [UIImageView]!
    @IBOutlet var fourPlusProfileImageView: [UIImageView]!
    
    @IBOutlet var chatroomNameLabel: UILabel!
    @IBOutlet var recentChatLabel: UILabel!
    @IBOutlet var recentChatDateLabel: UILabel!
    
    lazy var profileImageViewList = [oneProfileImageView, twoProfileImageView, threeProfileImageView, fourPlusProfileImageView]
    var currentProfileIamgeViewIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function)
        
        // circle 만들기
        makeCircleProfileImageView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        hideAllProfileImageView()
    }
}

// MARK: - Cell UI
extension TravelTalkTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        // 이미지 레이블
        for imageViews in profileImageViewList {
            for imageView in imageViews! {
                imageView.isHidden = true
                imageView.contentMode = .scaleAspectFill
                imageView.backgroundColor = .white
                imageView.layer.borderWidth = 0.2
                imageView.layer.borderColor = UIColor.gray.cgColor
            }
        }
        
        // 닉네임 레이블
        chatroomNameLabel.setLabel()
        chatroomNameLabel.setBold()
        chatroomNameLabel.numberOfLines = 1
        
        // 최근 채팅 레이블
        recentChatLabel.setLabel(style: .subtitle)
        recentChatLabel.numberOfLines = 2
        
        // 최근 채팅 날짜 레이블
        recentChatDateLabel.setLabel(style: .date)
    }
    
    func bindItem(data: Any) {
        guard let chatInfo = data as? ChatRoom else { return }
        currentProfileIamgeViewIndex = chatInfo.profileImageViewIndex
        
        // 프로필 이미지뷰
        for (imageView, imageStr) in zip(profileImageViewList[currentProfileIamgeViewIndex]!, chatInfo.chatroomImage) {
            imageView.isHidden = false
            imageView.image = UIImage(named: imageStr)
        }
        
        // 닉네임 레이블
        chatroomNameLabel.text = chatInfo.chatroomName
        
        // 최근 채팅 레이블
        recentChatLabel.text = chatInfo.recentChatMessage
        
        // 최근 채팅 날짜 레이블
        recentChatDateLabel.text = chatInfo.recentChatDate
    }
    
    // 모든 프로필 이미지뷰 가리기
    func hideAllProfileImageView() {
        for imageViews in profileImageViewList {
            for imageView in imageViews! {
                imageView.isHidden = true
                imageView.image = nil
            }
        }
    }
    
    // 프로필 이미지 뷰 Circle 만들기
    func makeCircleProfileImageView() {
        for imageView in profileImageViewList[currentProfileIamgeViewIndex]! {
            imageView.setCornerRadius(style: .circle(imageView))
        }
    }
}
