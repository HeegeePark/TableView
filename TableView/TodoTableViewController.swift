//
//  TodoTableViewController.swift
//  TableView
//
//  Created by 박희지 on 1/6/24.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var todoTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var list: [Todo] = [Todo(isChecked: true, title: "그립톡 구매하기", isStarred: true),
                        Todo(isChecked: false, title: "사이다 구매", isStarred: false),
                        Todo(isChecked: false, title: "아이패드 케이스 최저가 알아보기", isStarred: true),
                        Todo(isChecked: false, title: "양말", isStarred: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 추가 버튼 클릭 시
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // 내용이 있는지 확인
        guard let title = todoTextField.text, isExistContent(title) else {
            todoTextField.text = ""
            view.endEditing(true)
            return
        }
        
        let todo = Todo(isChecked: false, title: title, isStarred: false)
        
        list.append(todo)
        tableView.reloadData()
        
        todoTextField.text = ""
        view.endEditing(true)
    }
    
    // 내용이 존재하는지
    func isExistContent(_ content: String) -> Bool {
        return !content.replacingOccurrences(of: " ", with: "").isEmpty
    }
    
    // UI 디자인
    func setupUI() {
        // 테이블뷰
        tableView.backgroundColor = .white
        tableView.separatorColor = .lightGray
        
        // 헤더뷰 백그라운드 뷰
        headerView.backgroundColor = #colorLiteral(red: 0.951883018, green: 0.9470081925, blue: 0.9709880948, alpha: 1)
        headerView.layer.cornerRadius = 10
        
        // 헤더뷰 텍스트필드
        todoTextField.borderStyle = .none
        todoTextField.font = .systemFont(ofSize: 16)
        let attributeString = NSAttributedString(string: "무엇을 구매하실 건가요?",
                                                 attributes: [.foregroundColor: UIColor.lightGray,
                                                              .font: UIFont.systemFont(ofSize: 12)])
        todoTextField.attributedPlaceholder = attributeString
        todoTextField.textColor = .black
        
        
        // 헤더뷰 추가 버튼
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 13)
        addButton.backgroundColor = #colorLiteral(red: 0.8975048065, green: 0.8984213471, blue: 0.9142318368, alpha: 1)
        addButton.layer.cornerRadius = 8
    }
    
    // MARK: - UITableView
    // cell 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // cell 디자인 및 데이터 바인딩
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell
        cell?.setupUI(todo: todo)
        
        return cell ?? UITableViewCell()
    }
    
    // cell 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - Model
struct Todo {
    var isChecked: Bool
    var title: String
    var isStarred: Bool
}
