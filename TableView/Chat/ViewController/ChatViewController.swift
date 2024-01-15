//
//  ChatViewController.swift
//  TableView
//
//  Created by 박희지 on 1/12/24.
//

import UIKit

class ChatViewController: UIViewController {
    static let identifier = "ChatViewController"
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var inputAreaView: UIView!
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var inputTextButton: UIButton!
    
    @IBOutlet var inputAreaViewBottomMargin: NSLayoutConstraint!
    
    var chatRoom: ChatRoom?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureNavigationBar()
        configureTableView()
        scrollToBottom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNotification()
    }
    
    func updateData(data: ChatRoom) {
        self.chatRoom = data
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatRoom!.lastChatRow, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 키보드 올라올 때
    // TODO: 채팅 화면도 같이 올리는 법 고민해볼 것.
    @objc func keyboardWillShow(noti: Notification) {
        let notiInfo = noti.userInfo!
        
        // 키보드 높이
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        inputAreaViewBottomMargin.constant = -1 * height
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 키보드 내려갈 때
    @objc func keyboardWillHide(noti: Notification) {
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        self.inputAreaViewBottomMargin.constant = 0
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Custom UI
extension ChatViewController: CustomViewControllerProtocol, UITableViewControllerProtocol {
    func setupUI() {
        // 채팅 텍스트뷰
        configureTextView()
        
        // 전송 버튼
        // TODO: 버튼 안뜨는거 해결하기.
        var style = ButtonStyle.default
//        style.image = UIImage(named: "send")?.withRenderingMode(.alwaysOriginal)
        style.image = UIImage(systemName: "paperplane")
        style.tintColor = .gray
        style.backgroundColor = .blue
        inputTextButton.setButton(style: .default)
    }
    
    func configureTextView() {
        inputTextView.setCornerRadius()
        inputTextView.backgroundColor = #colorLiteral(red: 0.9686273932, green: 0.9686273932, blue: 0.9686273932, alpha: 1)
        inputTextView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 50)
        inputTextView.delegate = self
        inputTextView.textColor = .gray
        inputTextView.text = "메시지를 입력하세요"
    }
    
    func configureNavigationBar() {
        navigationItem.title = chatRoom?.chatroomName
        
        let leftButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.left"), target: self, action: #selector(popButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func configureTableView() {
        registerXib()
        connectDelegate()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func registerXib() {
        let xib1 = UINib(nibName: ChatReceiverTableViewCell.identifier, bundle: nil)
        tableView.register(xib1, forCellReuseIdentifier: ChatReceiverTableViewCell.identifier)
        
        let xib2 = UINib(nibName: ChatUserTableViewCell.identifier, bundle: nil)
        tableView.register(xib2, forCellReuseIdentifier: ChatUserTableViewCell.identifier)
    }
    
    func connectDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 키보드 옵저버 등록
    func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatRoom!.chatList[indexPath.row]
        
        if chat.isUserChat {   // 유저
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatUserTableViewCell.identifier) as? ChatUserTableViewCell else {
                return UITableViewCell()
            }
            
            cell.bindItem(data: chat)
            cell.selectionStyle = .none
            
            return cell
        } else {    // 수신자
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatReceiverTableViewCell.identifier) as? ChatReceiverTableViewCell else {
                return UITableViewCell()
            }
            
            cell.bindItem(data: chat)
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension ChatViewController: UITextViewDelegate {
    // 텍스트 커서가 없어지는 순간, 편집이 끝났을 때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메시지를 입력하세요"
            textView.textColor = .gray
        }
    }
    
    // 텍스트 커서가 시작하는 순간, 편집이 시작될 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .gray {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
