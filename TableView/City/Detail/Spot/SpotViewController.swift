//
//  SpotViewController.swift
//  TableView
//
//  Created by 박희지 on 1/11/24.
//

import UIKit

class SpotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    @objc func popButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Custom UI
extension SpotViewController: CustomViewControllerProtocol {
    func setupUI() {}
    
    func configureNavigationBar() {
        navigationItem.title = "관광지 화면"
        navigationController?.navigationBar.backgroundColor = .clear
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButtonClicked))
        navigationItem.leftBarButtonItem = leftButton
    }
}
