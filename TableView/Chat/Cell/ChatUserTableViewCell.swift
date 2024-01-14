//
//  ChatUserTableViewCell.swift
//  TableView
//
//  Created by 박희지 on 1/14/24.
//

import UIKit

class ChatUserTableViewCell: UITableViewCell {
    static let identifier = "ChatUserTableViewCell"

    @IBOutlet var bubbleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

extension ChatUserTableViewCell: UITableViewCellProtocol {
    func configureUI() {
        // 발신 메시지
        bubbleLabel.setLabel()
        bubbleLabel.numberOfLines = 0
        bubbleLabel.backgroundColor = #colorLiteral(red: 0.9055637717, green: 0.9055637717, blue: 0.9055637717, alpha: 1)
        bubbleLabel.setCornerRadius()
        bubbleLabel.layer.borderWidth = 0.2
        bubbleLabel.layer.borderColor = UIColor.gray.cgColor
        
        // 날짜
        dateLabel.setLabel(style: .date)
    }
    
    func bindItem(data: Any) {
        guard let chat = data as? Chat else { return }
        
        // 발신 메시지
        bubbleLabel.text = chat.message
        
        // 날짜
        dateLabel.text = chat.dateFormattedString
    }
}
